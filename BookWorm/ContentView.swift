//
//  ContentView.swift
//  BookWorm
//
//  Created by Isidoro Flores on 5/14/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    // we can sort our queries its always good practice to sort them for a predictable user experience
    
   // @Query(sort: \Book.title)var books : [Book]// this sorts the book alphabetically
    //This is how we sort them by highest to lowest rating
    @Query(sort: \Book.rating, order: .reverse) var books : [Book]
    
    
    @State private var showingAddScreen = false
    var body: some View {
        
        NavigationStack {
            List{
                ForEach(books){ book in
                    NavigationLink(value: book){
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                        VStack(alignment: .leading){
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("BookWorm")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add Book", systemImage: "plus"){
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen){
                AddBookView()
            }
            .navigationDestination(for: Book.self){ book in
                DetailView(book: book)
                
            }
        }
        
    }
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}


/*
 Creating a custom componenet with @Binding
 
 @Binding — passes a reference to a single value (Bool, Int, String, etc.) from a parent to a child view so the child can read and write it
   - @Bindable — used with @Observable classes so you can create $ bindings to any of its properties and pass them into views

 Tldr Binding small vals bindable clases or objects thaat own many values
 //
 //  ContentView.swift
 //  BookWorm
 //
 //  Created by Isidoro Flores on 5/14/26.
 //

 import SwiftUI

 struct PushButton : View {
     let title : String
     @State var isOn : Bool

     var onColors = [Color.red, Color.yellow]
     var offColors = [Color(white: 0.6), Color(white: 0.4)]
     
     var body: some View {
         Button(title){
             isOn.toggle()
         }
         .padding()
         .background(LinearGradient(colors : isOn ? onColors:  offColors, startPoint: .top, endPoint: .bottom))
         .foregroundStyle(.white)
         .clipShape(.capsule)
         .shadow(radius: isOn ? 0 : 5)
     
     }
 }

 struct ContentView: View {
     @State private var rememberMe = false
     var body: some View {
         VStack {
             PushButton(title: "Remember me", isOn: rememberMe)
             Text(rememberMe ? "On" : "Off")
         }
         .padding()
     }
 }

 #Preview {
     ContentView()
 }

 here we arent using a binding annotaiton and this means we create one value in vontent view pass it into button button changes it1 but doesnt pass it back so content view cant reflect the changes we can fix this by adding the binding annotaiton
 we add a binding to remember me because we are passing the binding tiself and not the value
 
 
 
 This is the corrected code below iwth bindigng to reflect the change of the button
 
 //
 //  ContentView.swift
 //  BookWorm
 //
 //  Created by Isidoro Flores on 5/14/26.
 //

 import SwiftUI

 struct PushButton : View {
     let title : String
     @Binding var isOn : Bool

     var onColors = [Color.red, Color.yellow]
     var offColors = [Color(white: 0.6), Color(white: 0.4)]
     
     var body: some View {
         Button(title){
             isOn.toggle()
         }
         .padding()
         .background(LinearGradient(colors : isOn ? onColors:  offColors, startPoint: .top, endPoint: .bottom))
         .foregroundStyle(.white)
         .clipShape(.capsule)
         .shadow(radius: isOn ? 0 : 5)
     
     }
 }

 struct ContentView: View {
     @State private var rememberMe = false
     var body: some View {
         VStack {
             PushButton(title: "Remember me", isOn: $rememberMe)
             Text(rememberMe ? "On" : "Off")
         }
         .padding()
     }
 }
 
 @AppStorage is used for non private information
 
 
 
 //SwiftData
 siwft data is an object graph and persistance framework
 it is a way to defien obkect their properties tore em and readn and write o em
 
it takes three steps to set up swift data
 we need to define the data first
 
 
 
 
 notes before bilding app
 
 //
 //  ContentView.swift
 //  BookWorm
 //
 //  Created by Isidoro Flores on 5/14/26.
 //

 import SwiftUI
 import SwiftData

 struct ContentView: View {

     @Query var students : [Student]
     //Loads data from the main context and allows us to querry from it as well
     //we need a property to access model contect
     
     @Environment(\.modelContext) var modelContext
     
     var body: some View {
         
         NavigationStack {
             List(students){ student in
                 Text(student.name)
                 
             }
             .navigationTitle("Classroom")
             .toolbar {
                 Button("Add"){
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna",
                     "Ron"]
                     
                     let lastNames = ["Granger", "Lovegood", "Potter",
                     "Weasley"]
                     
                     let chooseNames = firstNames.randomElement()!
                     let chooseLastNames = lastNames.randomElement()!
                     
                     // more code later
                     
                     let student = Student(id: UUID(), name: "\(chooseNames) \(chooseLastNames)")
                     modelContext.insert(student)
                 }
             }
         }
       
     }
 }

 #Preview {
     ContentView()
 }
 */
