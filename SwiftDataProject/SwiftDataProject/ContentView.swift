//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Isidoro Flores on 5/16/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    //How do we modify the below code to filter for data
    func sampleData() {
        try? modelContext.delete(model: User.self)
        let user1 = User(name: "Piper Chapman", city: "New York",joinDate:.now)
        let job1 = Job(name: "Organize sock drawer", priority: 3)
        let job2 = Job(name: "Make plans with Alex", priority: 4)
        modelContext.insert(user1)
        user1.jobs?.append(job1)
        user1.jobs?.append(job2)
    }
    
    @Query(sort: \User.name) var users: [User]
    //this is gppd but users dont care about capitalizzaiton they usually type in a few letters ijn the search bar and
    // ex pect some value to return so how can we make that happen
    
    // localizedStandardContains().
    

    var body: some View {


        NavigationStack {
            List(users) { user in
                HStack {
                    Text(user.name)
                    Spacer()
                    Text(String(user.jobs?.count ?? 0))
                        .fontWeight(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
                
                
            }
            .toolbar {
                Button("Add Sample users", systemImage: "plus"){
                    sampleData()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
    

/*Swift data objects are powefred by the same obsercation system that makes @Observable classes work  what does that mean?
 model objectrs are automatically picked u[p by swift uui
 
 //
 //  ContentView.swift
 //  SwiftDataProject
 //
 //  Created by Isidoro Flores on 5/16/26.
 //

 import SwiftUI
 import SwiftData

 struct ContentView: View {
     @Environment(\.modelContext) var modelContext
     @Query(sort: \User.name) var users: [User]
     @State private var path = [User]()
     
     var body: some View {
         NavigationStack(path: $path){
             List(users){ user in
                 NavigationLink(value: user){
                     Text(user.name)
                 }
             }
             .navigationTitle("Users")
             .navigationDestination(for: User.self){ user in
                 
                 EditUserView(user: user)
             }
             .toolbar{
                 Button("Add user", systemImage: "plus"){
                     let user = User(name: "", city: "", joinDate: .now)
                     modelContext.insert(user)
                     path = [user]
                 }
             }
         }
     }
 }
 the beauty of this is we edit code similarly to observable but we dont need to worry about reading and wrtiting as the modle macro handles that
 
 @Query(filter: #Predicate<User> { user in
     if user.name.localizedStandardContains("R"){
         if user.city == "London" {
             return true
         } else {
             return false
         }
     } else {
         return false
     }
 }, sort: \User.name) var users : [User]
// @State private var path = [User]()
 
 
 
 //
 //  ContentView.swift
 //  SwiftDataProject
 //
 //  Created by Isidoro Flores on 5/16/26.
 //

 import SwiftUI
 import SwiftData

 struct ContentView: View {
     @Environment(\.modelContext) var modelContext
     //How do we modify the below code to filter for data
     func sampleData() {
         try? modelContext.delete(model: User.self)
         let user1 = User(name: "Piper Chapman", city: "New York",joinDate:.now)
         let job1 = Job(name: "Organize sock drawer", priority: 3)
         let job2 = Job(name: "Make plans with Alex", priority: 4)
         modelContext.insert(user1)
         user1.jobs.append(job1)
         user1.jobs.append(job2)
     }
     
     @Query(sort: \User.name) var users: [User]
     //this is gppd but users dont care about capitalizzaiton they usually type in a few letters ijn the search bar and
     // ex pect some value to return so how can we make that happen
     
     // localizedStandardContains().
     

     var body: some View {


         NavigationStack {
             List(users) { user in
                 HStack {
                     Text(user.name)
                     Spacer()
                     Text(String(user.jobs.count))
                         .fontWeight(.black)
                         .padding(.horizontal, 10)
                         .padding(.vertical, 5)
                         .background(.blue)
                         .foregroundStyle(.white)
                         .clipShape(.capsule)
                 }
                 
                 
             }
             .toolbar {
                 Button("Add Sample users", systemImage: "plus"){
                     sampleData()
                 }
             }
         }
     }
 }

 #Preview {
     ContentView()
 }
     
 */
