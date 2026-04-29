//
//  ContentView.swift
//  MoonShot
//
//  Created by Isidoro Flores on 4/28/26.
//

import SwiftUI


struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label : {
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                
                                VStack{
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            ) .background(.darkBackground) 
                            .padding([.horizontal, .bottom])
                           
                           
                        }
                        
                    }
                    
                }
            }
            .navigationTitle("Moonshot")
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}

/*
 what does this code do??
 Image(.starwars)
         .resizable()
         .scaledToFit()
         .containerRelativeFrame(.horizontal){ size, axis in
             
             size * 0.8
             
         }
we are saying we want to give this image a frame relative to to the horizontal size of its parent
 //the size value will be the size value of the parent
 
 
 // Here we created a custom text view to depects how lazy modifies h and v stacks, they only appear when needed this alloows us to free up system resoruces 3
 // note fram width being infinity is what allows us to touch anywhere to make the view scroll
 struct CustomText: View {
     let text: String
     
     var body : some View {
         Text(text)
     }
     
     init(_ text: String){
         print("Creating a new custom text")
         self.text = text
     }
 }

 struct ContentView: View {
     var body: some View {
         ScrollView(.horizontal){
             LazyHStack(spacing : 10){
                 ForEach(0..<100){
                     CustomText("Item \($0)")
                         .font(.title)
                 }
                 
             }
             .frame(maxWidth: .infinity)
         }
     }
 }

 #Preview {
     ContentView()
 }

 This is how navigaiton link works, this is used in iMessage as well as other apple apps it provodes a back button
 
 NavigationStack {
     NavigationLink{
         Text("Detail View")
             
     } label : {
         VStack{
             Text("This is the label")
             Text("So is this")
             Image(systemName: "face.smiling")
         }
         .font(.largeTitle)
     }
     .navigationTitle("Swift UI")
 }
 
 Things to note
 Navigation link is used for related content aka digging deeper
 
 sheet is for unrelarted things like settinhs
 or a compose window
 
 wokring with Heirarchical data
 
 Here we have a button that decodes the json and prints the adress
 as u can see the json has nested data with address
 because of this we need to structure our struct in a specefic way
 
 Button("Decode JSON data"){
     let input = """
         {
         "name" : "Isidoro",
         "address": {
         "street" : "4213, Capistrano Way",
         "city" : "Los Angeles"
          }
         }
         """
 so how does this work>?
 we store the json in 1 and zero's format aka machine code
     let data = Data(input.utf8)
 we create an instance of jsondecoder here before we can use it
     let decoder = JSONDecoder()
 then we attekpt to decode our data and store it in the user struct and the data comes from data which is our stored input data that we converted into machine code
 notice that i said attempt sometimes it can faill we use if let to attmpt it if we are ale to do it the data is stored in user if not then we skip this return nil and our app wont crash
     if let user = try? decoder.decode(User.self, from: data){
         print(user.address.street)
     }
 }
 
 
 How do we structure the structs to accept this heirarchical data
 its pretty self explanaitory but basically what i am doing here is creating a strut for the first part then when we reach the nested part aka address we create another codable struct with that sub json data format
 
 struct User : Codable {
     let name : String
     let address : Address
 }

 struct Address : Codable {
     let street : String
     let city : String
 }

//  Grid view
 
 
 let layout = [GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80))]
 

 import SwiftUI

fit as many rows with minimpum points 80 max 120
 struct ContentView: View {
     let layout = [GridItem(.adaptive(minimum: 80, maximum: 120))]
     
     var body: some View {
         ScrollView(.horizontal){
             LazyHGrid(rows: layout){
                 ForEach(0..<1000){
                     Text("Item \($0)")
                 }
             }
         }
     
     }
 }

 #Preview {
     ContentView()
 }
 */
