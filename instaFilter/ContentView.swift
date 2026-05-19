//
//  ContentView.swift
//  instaFilter
//
//  Created by Isidoro Flores on 5/18/26.
//

import SwiftUI
// these are needed to create context and filter

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit // first step in asking user for their review

struct ContentView: View {

    @State private var proccessedImage: Image?
    @State private var filterIntensity = 0.5
    
    @State private var selectedItem : PhotosPickerItem?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()// expensive to make, keep alive
    
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        NavigationStack {
            Spacer()
            PhotosPicker(selection: $selectedItem){
                if let proccessedImage{
                    proccessedImage
                        .resizable()
                        .scaledToFit()
                } else {
                    ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                }
            }
            
            .onChange(of: selectedItem, loadImage)
            Spacer()
            HStack {
                Text("Intensity")
                Slider(value: $filterIntensity)
                    .onChange(of: filterIntensity, applyProcessing)
            }
            .padding(.vertical)
            HStack{
                Button("Change Filter", action: changeFilter)
                Spacer()
                if let proccessedImage {
                    ShareLink(item: proccessedImage, preview: SharePreview("Instafilter", image: proccessedImage))
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters){
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    @MainActor func setFilter(_ filter: CIFilter){
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        if filterCount >= 20{
            requestReview()
        }
    }
    func changeFilter(){
        showingFilters = true
        
    }
    func loadImage() {
        Task{
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {return }
            guard let inputImage = UIImage(data: imageData) else { return }
            // more code to come
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
  }
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey)
        { currentFilter.setValue(filterIntensity * 10, forKey:
        kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else {return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage = UIImage(cgImage:  cgImage)
        proccessedImage = Image(uiImage: uiImage)
        
        
    }
}

#Preview {
    ContentView()
}


/*  @State wraps your value and stores it outside the view in SwiftUI's memory. When the value changes, SwiftUI sees it, then rebuilds the whole view with the new value. So it's not modifying the view directly —
 it's swapping in a fresh copy of the view with the updated value.

 Your struct itself never actually "changes" — SwiftUI just throws it away and makes a new one.

 That is why the @Statte didnt activiate when the slider was being used
 use on change to track the change of a value now it works
 
 
 struct ContentView: View {
     @State private var blurrAmount = 0.0
     var body: some View {
         VStack {
             Text("Hello, world!")
                 .blur(radius: blurrAmount)
             Slider(value: $blurrAmount, in: 0...20)
                 .onChange(of: blurrAmount){ oldValue, newValue in
                     print("new value is \(newValue)")
                     
                 }
             Button("Random blur Amount"){
                 blurrAmount  = Double.random(in: 0...20)
             }
         }
         .padding()
     }
 }

 #Preview {
     ContentView()
 }

 
 // Below is the code fro showing multiple options with a confirmation dialogue
 import SwiftUI

 struct ContentView: View {
 @State private var showingConfirmation = false
     @State private var backgroundColor = Color.white
     var body: some View {
             Button("Hello world!!!!!!"){
                 showingConfirmation = true
             }
             .frame(width: 300, height: 300)
             .background(backgroundColor)
             .confirmationDialog("Change Background", isPresented: $showingConfirmation){
                 Button("Red"){backgroundColor = .red}
                 Button("Green"){backgroundColor = .green}
                 Button("Blue"){backgroundColor = .blue}
                 Button("Cancel", role: .cancel){ }
             } message:  {
                 Text("Select a new Color")
             }
     }
 }

 #Preview {
     ContentView()
 }

 /////////////Integrating core image iwht core data
 
 
 // if we want to use core image swift ui is a good endpoint but not useful for us  anywehre else
 
 three image tyoes that can give us more power to image manipulation
 
 UIImage is one, it allows us to modify bit map images like pngs  and vectors like svg even sequqneses that form an image
 CGImage comes from core graphiss its a simpler library two dimenssional arrya of pixels
 CIImage comes form core image e. This stores all the information required to
 produce an image but doesn’t actually turn that into pixels unless it’s asked to. Apple
 calls CIImage “an image recipe” rather than an actual image.
 
 We can create a UIImage from a CGImage, and create a CGImage from a UIImage.
• We can create a CIImage from a UIImage and from a CGImage, and can create a
CGImage from a CIImage.
• We can create a SwiftUI Image from both a UIImage and a CGImage.
 
 
 we changed the image into a CGI
 and then from there to CCI core image
 next we  applied filters and now we need to convert that back inti a swiftui view
 
 examples of newer api
 
 let inputImage = UIImage(resource: .example) //creating our example imagee UIImage(resource: )
 let beginImage = CIImage(image: inputImage)  //converting the uiimage into core image
 // builing context
 let context = CIContext()
 //adding differewnt filters here
// let currentFilter = CIFilter.pixellate()
 //let currentFilter = CIFilter.crystallize()
 let currentFilter = CIFilter.twirlDistortion()
 currentFilter.inputImage = beginImage
 //currentFilter.intensity = 1
 //currentFilter.scale = 100
 //currentFilter.radius = 100
 currentFilter.radius = 1000
 currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
 
 
 
 import CoreImage
 import CoreImage.CIFilterBuiltins

 struct ContentView: View {
     @State private var image : Image?
     var body: some View {
         VStack{
             image?
                 .resizable()
                 .scaledToFit()
         }
         .onAppear(perform: loadImage) // attached if image is nill it won appaear
     }
     func loadImage(){
         let inputImage = UIImage(resource: .example) //creating our example imagee UIImage(resource: )
         let beginImage = CIImage(image: inputImage)  //converting the uiimage into core image
         // builing context
         let context = CIContext()
         //adding differewnt filters here
        // let currentFilter = CIFilter.pixellate()
         //let currentFilter = CIFilter.crystallize()
         let currentFilter = CIFilter.twirlDistortion()
         currentFilter.inputImage = beginImage
         
         let amount = 1.0
         let inputKeys = currentFilter.inputKeys
         
         if inputKeys.contains(kCIInputIntensityKey){
             currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
         }
         if inputKeys.contains(kCIInputRadiusKey){
             currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey )
         }
         if inputKeys.contains(kCIInputScaleKey){
             currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
         }
         //currentFilter.intensity = 1
         //currentFilter.scale = 100
         //currentFilter.radius = 100
       
         
         
         // get a CIImage from our filter or exit if that fails
         guard let outputImage = currentFilter.outputImage else
         {return}
         
         //Attempt to get a cgi image from our ciimage
         guard let cgImage = context.createCGImage(outputImage, from : outputImage.extent) else {return}
         //convert that into a UIImage
         let uiImage = UIImage(cgImage: cgImage)
         
         // then we convert that into a swiftui image
         image = Image(uiImage: uiImage)
         
     }
 }

 #Preview {
     ContentView()
 }

 
 // No data view
 //And if you want full control, you can provide individual views for the title and description, along with some buttons to display to help the user to get started:
 
 ContentUnavailableView{
     Label("No snippets", systemImage: "swift")
 } description: {
     Text("You dont have any snippets yet!")
 } actions : {
     Button("Create snippet"){}
         .buttonStyle(.borderedProminent)
 }
 
 // how to load photos from users photo library
 // store the selected item and then store the selected item as a swiftui image
 // this matters because the selected item is a reference to the photo libraru until we need to l oad the image
 //@State private var pickerItem : PhotosPickerItem?
 //we can pass a binding to an array of picker items to allow users to select various mimages
 @State private var pickerItems = [PhotosPickerItem]()
 @State private var selectedImages = [Image]()
// @State private var selectedImage : Image?
 var body: some View {
     
     
     VStack {
         // u can also specify which images are allowed
        /*/ PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .images){
             Label("Select a picture", systemImage: "photo")
         }
         */
         
         // u can also specify which images are allowed
         PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .all(of: [.images, .not(.screenshots)])) {
             Label("Select a picture", systemImage: "photo")
         }
         ScrollView {
             ForEach(0..<selectedImages.count, id: \.self){ i in
                 selectedImages[i]
                     .resizable()
                     .scaledToFit()
             }
         }
         //next step is to watch if pickeritem changes because if it does it means the user sslected a photo
         
         .onChange(of: pickerItems){
             Task {
                 selectedImages.removeAll()
                 for item in pickerItems {
                     if let loadedImage = try await item.loadTransferable(type: Image.self){
                         selectedImages.append(loadedImage)
                     }
                 }
             }
         }
     }
     
 }
     
}

#Preview {
 ContentView()
}
 
 ///// how to let the suer share content with sharelinkl
 
 import SwiftUI
 // these are needed to create context and filter

 import CoreImage
 import CoreImage.CIFilterBuiltins
 import PhotosUI

 struct ContentView: View {
     var body: some View {
         //basic we can also attach a subject
        // ShareLink(item: URL(string: "https://www.hackingwithswift.com")!)
         // u can customize the subject via lable
         /*ShareLink(item: URL(string: "https://www.hackingwithswift.com")!,subject: Text("Learn swiftui here"), message: Text("Checkout the 100 days of SwiftUI!!"))
          // here creating a custom label
          ShareLink(item: URL(string: "https://www.hackingwithswift.com")!){
              Label("Spread the word about swift!", systemImage: "swift")
          }*/
         // we can also provide a prevwi whch is important to give the recipient an idea of whats inside
         let example = Image(.example)
         ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example)){
             Label("Click to share", systemImage: "airplane")
         }
        
         
     }
         
 }

 #Preview {
     ContentView()
 }
 
 ////////////// how to ask the user to leave an appstore review
 
 //
 //  ContentView.swift
 //  instaFilter
 //
 //  Created by Isidoro Flores on 5/18/26.
 //

 import SwiftUI
 // these are needed to create context and filter

 Not ideal to leave a button call request review after  auser has achoeves a certain number of tasks withun the app
 that way they have experiences the beneifit of the app
 
 import CoreImage
 import CoreImage.CIFilterBuiltins
 import PhotosUI
 import StoreKit // first step in asking user for their review

 struct ContentView: View {
     @Environment(\.requestReview) var requestReview
     var body: some View {
         
         Button("Leave a review"){
             requestReview()
         }
     }
         
 }


*/
