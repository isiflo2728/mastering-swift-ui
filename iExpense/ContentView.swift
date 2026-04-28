//
//  ContentView.swift
//  iExpense
//
//  Created by Isidoro Flores on 4/27/26.
//

import SwiftUI



struct ContentView: View {
    //@Statte keeps the object aluve but observablel is what lets us update the ui view
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var options = ["Business", "Personal"]
    @State private var option = ""
    
    var filteredItems: [ExpenseItem]{
        expenses.items.filter{ $0.type == option}
    }
    
    var body : some View {
        
        NavigationStack{
            Picker("Type", selection: $option) {
                ForEach(options, id: \.self){
                    Text($0)
                }
            }.pickerStyle(.segmented)
                List{
                    // ForEach(expenses.items, id: \.id){ item in
                    // we can do this instead of the other cuz od identifiable
                    
                    ForEach(filteredItems){ item in
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            
                        }
                    }
                    .onDelete(perform: removeItems)
                    
                }
                .navigationTitle("iExpense")
                .toolbar{
                    Button("Add Expenses", systemImage: "plus"){
                        showingAddExpense = true
                    }
                }
                .sheet(isPresented: $showingAddExpense){
                    AddView(expenses: expenses)
                }
            
        }
        
    }
    
    func removeItems(at offsets: IndexSet){
        let item = filteredItems[offsets.first!]
        if let index = expenses.items.firstIndex(where: { $0.id == item.id}) {
            expenses.items.remove(at: index)
        }
    }
    
}

#Preview {
    ContentView()
}

/*
 Notes
 import SwiftUI
 import Observation

 @Observable
 class User {
     var firstName = "Isidoro"
     var lastName = "Flores"
 }

 struct ContentView: View {
     @State private var user = User()
     var body: some View {
         VStack {
             Text("Your name is \(user.firstName) \(user.lastName)")
             
             TextField("First Name: ", text: $user.firstName)
             
             TextField("Last Name: ", text: $user.lastName)
           
         }
         .padding()
     }
 }
 
 @State works with structs, and with classses they do update the vlass values however they dont rewrite ui
 to do so we need the observable macro above the class and this is o that the class can write changes it observed back to the ui
 
/// This is how you use @enviroment macro to create a button on a sheet to dimiss via a click instead of swipe feature that comes with sheets
 
 import SwiftUI
 import Observation

 struct SecondView: View {
     @Environment(\.dismiss) var dismiss
     let name: String
     var body: some View {
  
         
         Button("Dismiss"){
             dismiss()
         }
     }
 }

 struct ContentView: View {
 @State private var showingSheet = false
     var body: some View {
         Button("Show sheet"){
             showingSheet.toggle()
         }
         .sheet(isPresented: $showingSheet){
             SecondView(name: "Isidoro Flores")
         }
     }
        
 }

 
 #Preview {
     ContentView()
 }
 
 // user creates a list of items that they can swipe to the left to delete, ]
 can hit edit nutton to have more customizability fot deleting
 
 import SwiftUI
 import Observation

 struct ContentView: View {
     @State private var numbers = [Int]()
     @State private var currentNumbers = 1
     
     var body: some View {
         NavigationStack {
             VStack{
                 List{
                     ForEach(numbers, id: \.self){
                         Text("Row \($0)")
                     }
                     .onDelete(perform: removeRows)
                 }
                 
                 Button("Add number"){
                     numbers.append(currentNumbers)
                     currentNumbers += 1
                 }
             }
              .toolbar{
                 EditButton()
             }
         }
         
         
     }
     
     func removeRows(at offsets: IndexSet){
         numbers.remove(atOffsets: offsets)
     }
        
 }

 #Preview {
     ContentView()
 }
 truct ContentView: View {

     @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
     var body: some View {
         Button("Tap count: \(tapCount)"){
             tapCount += 1
             UserDefaults.standard.set(tapCount, forKey: "Tap")
         }
     }
     
 }
 @AppStorage("Tap count") private var tapCount = 0
     var body: some View {
         Button("Tap count: \(tapCount)"){
             tapCount += 1
         }
     }
     
 }

 #Preview {
     ContentView()
 }
This does the same as user storage but with les code, it is incredibly bare bones as of now, if data cant be returns it returns 0 by default
 
 
 /// This is show we ocnvert data into json data 
 
 struct User: Codable {
     let firstName : String
     let lastName : String
 }

 struct ContentView: View {
     @State private var user = User(firstName: "Isidoro", lastName: "Flores")
     var body : some View {
         Button("Save user"){
             let encoder = JSONEncoder()
             if let data = try? encoder.encode(user){
                 UserDefaults.standard.set(data, forKey:"UserData")
             }
         }
     }
     
 }

 #Preview {
     ContentView()
 }

 */
