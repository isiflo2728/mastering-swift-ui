//
//  ContentView.swift
//  cupcakeCorner
//
//  Created by Isidoro Flores on 5/7/26.
//

import SwiftUI

@Observable
class Order : Codable{
    static let types = ["Vanilla", "StrawBerry", "Chocolate", "Rainbow"]
    
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false{
        didSet {
            if specialRequestEnabled == false{
                 extraFrosting = false
                 addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var hasAddress : Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty{
            return false
        }
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if addSprinkles{
            cost += Decimal(type) / 2
        }
        
        return cost
    }
}



struct ContentView: View {
@State private var order = Order()
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type){
                        ForEach(Order.types.indices, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value : $order.quantity, in: 3...20)
                }
                
                Section{
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled{
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        
                        Toggle("Add extra sprink;es", isOn: $order.addSprinkles)
                    }
                }
                
                Section{
                    NavigationLink("Delivery Details"){
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("CupCake Corner")
        }
    }
}


#Preview {
    ContentView()
}


/*
 import SwiftUI

 struct Response: Codable {
     var results: [Result]
 }

 struct Result : Codable {
     var trackId : Int
     var trackName : String
     var collectionName : String
 }


 struct ContentView: View {
     
     @State private var results = [Result]()
     var body: some View {
         List(results,  id : \.trackId) { item in
             VStack(alignment: .leading){
                 Text(item.trackName)
                     .font(.headline)
                 Text(item.collectionName)
             }
             }.task {
                 await loadData()
             
         }
         
     }
     func loadData() async{
         guard let url = URL(string : "https://itunes.apple.com/search?term=bleachers&entity=song") else {
             print("Invalid url")
             return
         }
         
         do {
             let (data, _) = try await URLSession.shared.data(from: url)
             if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
             results = decodedResponse.results
             }
             
         } catch {
             print("Invalid url")
         }
         
         
        
     }
 }
 
 How to get data from a link
 
 this is how to modify a photo using an asyn image link
 
   AsyncImage(url : URL(string: "https://hws.dev/img/logo.png"),
              scale: 3){
       image in
       image
           .resizable()
           .scaledToFit()
   } placeholder: {
       Color.red
   }
   .frame(width: 200, height: 200)
 Form {
     Section{
         TextField("Username", text: $username)
         TextField("Email", text : $email)
     }
     Section{
         Button("Create Account"){
             print("Creating account...")
         }
     }
     .disabled(disableForm)
 }
 
 
 using coding keys to change the way its encoded and decoded or else name would be re written _name
 @Observable
 class User : Codable {
     enum CodingKeys : String, CodingKey {
         case _name = "name"
     }
     var name = "Izzy"
 }

 struct ContentView: View {

     var body: some View {
         Button("Encode Izzy", action : encodeIzzy)
         
     }
     func encodeIzzy() {
         let data  = try! JSONEncoder().encode(User())
         let str = String(decoding : data, as : UTF8.self)
         print(str)
     }
 Small Colisions
 // .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5),
 trigger: counter)
 //Heavy Collisionso
 .sensoryFeedback(.impact(weight: .heavy, intensity: 1),
 trigger: counter)
 
 Button("Tap count: \(counter)"){
     counter += 1
 }
 .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: counter)
 
 Notes
 Used an observablel class whih means it uodatd across views
 @state is used on the first declaration of our class and therefore it becomes our parent class
 after that we can use @Binding to properties whoch allows us to create that two way binding
 this matters because withoiut any extra code when a user navigates back to the order page their adress gets saved anyway, which is cool because the user doesnt need to re add theiri adress
 
 
 */
