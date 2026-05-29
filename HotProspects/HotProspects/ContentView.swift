//
//  ContentView.swift
//  HotProspects
//
//  Created by Isidoro Flores on 5/27/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    ContentView()
}

/*
 Letting users select from a list
 import SwiftUI

 struct ContentView: View {
     let users = ["Isidoro Flores", "John Doe", "Jane Doe", "Jane Smith", "John Smith"]
     // u can modify this to hanfle multiple selections
     //@State private var selection: String?
     @State private var selection = Set<String>()
     var body: some View {
         EditButton()
         List(users, id: \.self, selection: $selection){ users in
             Text(users)
         }
         if selection.isEmpty == false{
             Text("You selected \(selection.formatted())")
         }

     }
 }

 #Preview {
     ContentView()

 ///////////TAB VIEW NOTES
 Tip: It's common to want to use NavigationStack and TabView at the same time, but you
 should be careful: TabView should be the parent view, with the tabs inside it having a
 NavigationStack as necessary, rather than the other way around.


 Import SwiftUI

 struct ContentView: View {
     @State private var selectedTab = "One"
     var body: some View {
         TabView(selection: $selectedTab){
             Button("Show tab two"){
                 selectedTab = "Two"
             }
             .tabItem {
                     Label("One", systemImage: "star")
                 }
             .tag("One")
             Button("Show tab one"){
                 selectedTab = "One"
             }
                 .tabItem {
                     Label("Two", systemImage: "circle")
                 }
                 .tag("Two")
         }
     }
 }

 #Preview {
     ContentView()
 }
 }

 // Understanding swifts result type

 import SwiftUI

 struct ContentView: View {

   @State private var output = ""
     var body: some View {
         Text(output)
             .task {
                 await fetchReadings()

             }
     }
     func fetchReadings() async {
         /*That code works just fine, but it doesn't give us a lot of flexibility – what if we want to stash
          the work away somewhere and do something else while it's running? What if we want to read
          its result at some point in the future, perhaps handling any errors somewhere else entirely? Or
          what if we just want to cancel the work because it's no longer needed?
         do {
             let url = URL(string: "https://hws.dev/readings.json")!
             let (data, _) = try await URLSession.shared.data(from: url)
             let readings = try JSONDecoder().decode([Double].self, from: data)
             output = "Found \(readings.count) readings"
         } catch {
             print("Download erros")
         }
          */
         func fetchReadings() async {
             let fetchTask = Task {
                 let url = URL(string: "https://hws.dev/readings.json")!
                 let (data, _) = try await URLSession.shared.data(from: url)
                 let readings = try JSONDecoder().decode([Double].self, from: data)
                 return "Found \(readings.count) readings"
             }
         }
     }
 }

 import SwiftUI

 struct ContentView: View {


     var body: some View {
         Image(.example)
             .interpolation(.none)
             .resizable()
             .scaledToFit()
             .background(.black)
     }
 }

 #Preview {
     ContentView()
 }
 //// Context Menus
 mport SwiftUI

 struct ContentView: View {
     @State private var backgroundColor = Color.red
     var body: some View {
         VStack{
             Text("Hello, world!")
                 .padding()
                 .background(backgroundColor)
             Text("Change Color")
                 .padding()
                 .contextMenu{
                     Button("Red"){
                         backgroundColor = .red
                     }
                     Button("Green"){
                         backgroundColor = .green
                     }
                     Button("Blue"){
                         backgroundColor = .blue
                     }
                 }
         }
     }
 }
 /// swipep for more options
 struct ContentView: View {

     var body: some View {
         List{
             Text("Taylor Swift")
                 .swipeActions{
                     Button("Delete", systemImage: "minus.circle", role: .destructive){
                         print("Deleting")
                     }
                 }
                 .swipeActions(edge: .leading){
                     Button("Pin", systemImage: "pin"){
                         print("Pinning")
                     }
                     .tint(.orange)
                 }
         }
     }
 }

 #Preview {
     ContentView()
 }
 ////////////// Notifications
 /
 //  ContentView.swift
 //  HotProspects
 //
 //  Created by Isidoro Flores on 5/26/26.
 //

 import SwiftUI
 import UserNotifications

 struct ContentView: View {

     var body: some View {
         VStack{
             Button("Request Permission"){
                 UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                     if success{
                         print("All set!")
                     } else if let error {
                         print(error.localizedDescription)
                     }

                 }
             }

             Button("Schedule Notification"){
                 let content = UNMutableNotificationContent()
                 content.title = "Feed the cat"
                 content.subtitle = "It looks hungry"
                 content.sound = UNNotificationSound.default
                 let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                 let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                 UNUserNotificationCenter.current().add(request)
             }
         }
     }
 }
*/
