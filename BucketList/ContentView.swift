//
//  ContentView.swift
//  BucketList
//
//  Created by Isidoro Flores on 5/18/26.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3), span : MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onTapGesture {
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) { newLocation in
                        viewModel.update(location: newLocation)
                    }
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
    
}

#Preview {
    ContentView()
}

/*
 ////////////////Adding conformance to comparable for custom data tyoes
 
 //
 //  ContentView.swift
 //  BucketList
 //
 //  Created by Isidoro Flores on 5/18/26.
 //

 import SwiftUI
 struct User: Identifiable, Comparable{
     var id = UUID()
     var firstName: String
     var lastName: String
     
     // function is less that we are adding functionality to the operator this is clled operator overloading
     // lhs and rhs are shorthand for left hand side and irght hand side
     // this method must return a boolean there is no room for equal that is handled by a different protocal equitable
     //fourth the method is static whoch means it is called within the ztruct and no an instance fo the struct
     /*This resolves the problems we had before: we now isolate our model functionality in the struct
      itself, and we no longer need to copy and paste code around – we can use sorted() everywhere,
      safe in the knowledge that if we ever change the algorithm then all our code will adapt.
      */
     static func < (lhs: User, rhs: User)-> Bool{
         lhs.lastName < rhs.lastName
     }
 }

 struct ContentView: View {
     let users = [
         User(firstName: "Isidoro", lastName: "Flores"),
         User(firstName: "Sanskar", lastName: "Thapa"),
         User(firstName: "Joshua", lastName: "Soteras")
     ].sorted()
     // the above code is not good pracitce because htis is model code
     //  we are affecting the way we work with the user struct  we shouldnt tell how our model shoul dbehave inside our swiftui code we can make the struct conform to the comparable protocal and in that way itll let us use the sorted wihtout any parameters
     
     // we dont need to tell swift how sorted workks becauase it understnand how to sort numbers
     
     
     let values = [1,5,3,6,2,9]
     var body: some View {
         List(values, id: \.self){ value in
             Text(String(value))
         }
         
         List(users){ user in
             Text("\(user.lastName), \(user.firstName)")
         }
     }
 }

 #Preview {
     ContentView()
 }

 ////////////////////////////////Writing data to the documents directory /////////////////////
 
 
 //
 //  ContentView.swift
 //  BucketList
 //
 //  Created by Isidoro Flores on 5/18/26.
 //

 import SwiftUI

 struct ContentView: View {
     var body: some View {
         Button("Read and write"){
             let data = Data("Test message".utf8)
             let url = URL.documentsDirectory.appending(path:"message.txt")
             do{
                 try data.write(to: url, options: [.atomic, .completeFileProtection])
                 let input  = try String(contentsOf: url)
                 print(input)
             } catch {
                 print(error.localizedDescription)
             }
         }
     }
 }
 
 ////////////////SWITCHING VIEW STATES WITH ENUMS/////////////////////
 switch loadingState {
 case .loading:
 LoadingView()
 case .success:
 SuccessView()
 case .failed:
 FailedView()
 }
  TIP:  Switching over an enum has the advantage that Swift checks all our cases are covered
 correctly, which means if you add another case in the future you'll be told to handle it
 correctly.
 
 //  ContentView.swift
 //  BucketList
 //
 //  Created by Isidoro Flores on 5/18/26.
 //

 import SwiftUI

 enum LoadingState {
     case loading, success, falied
 }
 struct LoadingView: View {
     var body: some View {
         Text("Loading...")
     }
 }
 struct SuccessView : View {
     var body : some View {
         Text("Success")
     }
 }
 struct FailedView : View {
     var body : some View {
         Text("Failed.")
     }
 }
 struct ContentView: View {
     @State private var loadingState = LoadingState.loading
     var body: some View {
         if loadingState == .loading {
             LoadingView()
         } else if loadingState == .success {
             SuccessView()
         } else if loadingState == .falied {
             FailedView()
         }
         
     }
 }

 #Preview {
     ContentView()
 }
 
 /////////////////////// Integratinf map kit into our code
 • Hold down the Option key to trigger two-finger pinching. If you click and drag while
 option is held down, the virtual fingers will move closer or further.
 • Hold down Option and Shift to trigger two-finger panning. If you click and drag up and
 down while this combination is held down, you'll adjust the tilt of the map.
 • You can also mimic the single-finger zoom by tapping once, then tapping and dragging
 up or down.
 
 
 / code for initioal position
 
 
 struct ContentView: View {

     var body: some View {
         // Satelyte style
           //  .mapStyle(.imagery)
         // we can customize interactions or none
         //        Map(interactionModes: [.rotate, .zoom])
         // here the map is always fixed
         // Map(interactionModes: [])
         let position = MapCameraPosition.region(
             MKCoordinateRegion(
                 center: CLLocationCoordinate2D(latitude:51.507222, longitude: -0.1275 ), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
             )
         )
         Map(initialPosition: position)
        // Map(interactionModes: [])
             //   .mapStyle(.hybrid(elevation: .realistic))
             //satelite and street map
     }
 }
 //
 //  ContentView.swift
 //  BucketList
 //
 //  Created by Isidoro Flores on 5/18/26.
 //

 import SwiftUI
 import MapKit

 struct ContentView: View {
     @State private var position = MapCameraPosition.region(
          MKCoordinateRegion(
              center: CLLocationCoordinate2D(latitude:51.507222, longitude: -0.1275 ), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
          )
      )

     var body: some View {
         // Satelyte style
           //  .mapStyle(.imagery)
         // we can customize interactions or none
         //        Map(interactionModes: [.rotate, .zoom])
         // here the map is always fixed
         // Map(interactionModes: [])
       
         Map(position: $position)
             .onMapCameraChange(frequency: .continuous) { context in
                 print(context.region)
                 
             }
        // Map(interactionModes: [])
             //   .mapStyle(.hybrid(elevation: .realistic))
             //satelite and street map
         HStack(spacing: 50){
             Button("Paris"){
                 position = MapCameraPosition.region(
                     MKCoordinateRegion(
                     center: CLLocationCoordinate2D(latitude: 48.8566,
                     longitude: 2.3522),
                     span: MKCoordinateSpan(latitudeDelta: 1,longitudeDelta: 1)
                 )
             )
             }
             Button("Tokyo") {
             position = MapCameraPosition.region(
             MKCoordinateRegion(
             center: CLLocationCoordinate2D(latitude: 35.6897,
             longitude: 139.6922),
             span: MKCoordinateSpan(latitudeDelta: 1,
             longitudeDelta: 1)
             )
             )
             }
         }
     }
 }
 
 //custom map annotations
 //
 //  ContentView.swift
 //  BucketList
 //
 //  Created by Isidoro Flores on 5/18/26.
 //

 import SwiftUI
 import MapKit

 struct Location : Identifiable{
     let id = UUID()
     let name: String
     let coordinate: CLLocationCoordinate2D
 }

 struct ContentView: View {

     var body: some View {
         let locations = [
         Location(name: "Buckingham Palace", coordinate:
         CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
         Location(name: "Tower of London", coordinate:
         CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
         ]
         
     
         
         Map {
             ForEach(locations){ location in
                 Annotation(location.name, coordinate: location.coordinate){
                     Text("Location Name")
                         .font(.headline)
                     .padding()
                     .background(.blue)
                     .foregroundStyle(.white)
                     .clipShape(.capsule)
                 }
                 .annotationTitles(.hidden)
              
             }
         }
     }
     
 }

 #Preview {
     ContentView()
 }
//// this is how to register user touches on the map
 
 
 //  ContentView.swift
 //  BucketList
 //
 //  Created by Isidoro Flores on 5/18/26.
 //

 import SwiftUI
 import MapKit


 struct ContentView: View {

     var body: some View {
         MapReader{ proxy in
              Map()
                 .onTapGesture { position in
                     if let coordinate = proxy.convert(position, from: .local){
                         print(coordinate)
                     }
                 }
         }
     }
     
 }
 
////Intergrating Touch ID and FaCE id
 
 
 import SwiftUI
 import MapKit
 import LocalAuthentication

 struct ContentView: View {
 @State private var isUnlocked = false
     
     var body: some View {
         VStack {
             if isUnlocked {
                 Text("Unlocked")
             } else {
                 Text("Locked")
             }
         }
         .onAppear(perform: authenticate)
     }
     
     func authenticate() {
         let context = LAContext()
         var error : NSError?
         
         // check if biometric authentication is availble
         
         if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
             let reason = "We need to unlock your data"
             
             context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                 isUnlocked = true
                 if success {
                     // Authenticated succesfully
                 } else {
                     // There was A problem
                 }
                 
             }
         } else {
             // No Biometrics
         }
     }
     
 }

 #Preview {
     ContentView()
 }

 */

