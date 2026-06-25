//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Isidoro Flores on 6/17/26.
//


import SwiftUI




struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else{
            resorts.filter{
                $0.name.localizedStandardContains(searchText)
            }
        }
    }
    
    @State private var favorites = Favorites()
    
    var body: some View {
        NavigationSplitView{
            List(filteredResorts){ resort in
                NavigationLink(value: resort){
                    HStack{
                        Image(resort.country)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                    }
                    if favorites.contains(resort){
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                            .foregroundStyle(.red)
                    }
                    
            }
                
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
                
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
        } detail: {
            WelcomeView()
        }
        .environment(favorites)

    
    }
     
    
}

#Preview {
    ContentView()
}


// Navigaiton view with title looks good on ios but what about ipad os there is more realistateee
/*
 // yOU CAN tell siwft ui whoch view to prefer
 //NavigationSplitView(columnVisibility: .constant(.all)){
 // above code is to show all abd below is to prfer one
 NavigationSplitView(preferredCompactColumn: .constant(.detail)){
     NavigationLink("Primary"){
         Text("Next View")
     }
 }detail: {
     Text("Content")
         .navigationTitle("ContentView")
 }
 .navigationSplitViewStyle(.balanced)c
 
 
 
 Using optionals with sheets and alerts
 /


 struct User : Identifiable {
     var id = "Taylor Swift"
 }

 import SwiftUI

 struct ContentView: View {
     
     @State private var selectedUser: User? = nil
     
     var body: some View {
         Button("Tap Me"){
             selectedUser = User()
         }
         .sheet(item: $selectedUser){  user in
             Text(user.id)
             }
         }

 }

 #Preview {
     ContentView()
 }

 
 
 struct User : Identifiable {
     var id = "Taylor Swift"
 }

 import SwiftUI

 struct ContentView: View {
     
     @State private var isShowingUser = false
     @State private var selectedUser: User? = nil
     
     var body: some View {
         Button("Tap me"){
             selectedUser = User()
             isShowingUser = true
         }
         .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser){ user in
             Button(user.id){}
         }
         }

 }
 /// Size of sheet can be changed with the following code below
 
 struct User : Identifiable {
     var id = "Taylor Swift"
 }

 import SwiftUI

 struct ContentView: View {
     
     @State private var isShowingUser = false
     @State private var selectedUser: User? = nil
     
     var body: some View {
         Button("Tap me"){
             selectedUser = User()
             isShowingUser = true
         }
         .sheet(item: $selectedUser){ user in
             Text(user.id)
                 .presentationDetents([.medium, .large])
         }
     }

 }

 #Preview {
     ContentView()
 }
 //\
 
 //
 //  ContentView.swift
 //  SnowSeeker
 //
 //  Created by Isidoro Flores on 6/17/26.
 //
 import SwiftUI

 struct UserView : View {
     var body: some View {
         Group{
             Text("Name: Isidoro")
             Text("Country: United States")
             Text("Pets: Marty and Scooby")
         }.font(.title)
     }
 }

 struct ContentView: View {
     @Environment(\.horizontalSizeClass) var horisontalSizeClass
     
     var body: some View {
         if horisontalSizeClass == .compact {
             VStack(content: UserView.init)
             } else{
                 HStack(content: UserView.init)
             }
         }

 }

 #Preview {
     ContentView()
 }
 
 group changes its view based on the parents organixation
 we use enviroment to keep track of the space of the screen and that way we can have our view change dependent on layout
 
 
 //View that fits is awesome and simple however it restricts ur own customizability
 
 
 import SwiftUI


 struct ContentView: View {
  
     var body: some View {
         ViewThatFits{
             Rectangle()
                 .frame(width: 500, height: 200)
             Circle()
                 .frame(width: 200, height: 200)
         }
        
     }

 }

 #Preview {
     ContentView()
 }

 
 
 ////////// Making swift ui view searchable
 
 //
 //  ContentView.swift
 //  SnowSeeker
 //
 //  Created by Isidoro Flores on 6/17/26.
 //
 import SwiftUI


 struct ContentView: View {
     @State private var searchText = ""
     let allNames = ["Isidoro", "Eduardo", "Lizbeth", "Ashley", "Isidoro Jr", "Hortensia"]
     
     var filteredNames: [String] {
         if searchText.isEmpty{
             allNames
         } else {
             allNames.filter{$0.localizedStandardContains(searchText)}
         }
     }
     
     var body: some View {
         NavigationStack{
             List(filteredNames, id: \.self){ name in
                 Text(name)
             }
             .searchable(text: $searchText, prompt: "Look for something" )
             .navigationTitle("Searching")
         }
        
     }

 }

 #Preview {
     ContentView()
 }
 //sharing Observable objects in swift ui's ennviroment
 
 //
 //  ContentView.swift
 //  SnowSeeker
 //
 //  Created by Isidoro Flores on 6/17/26.
 //


 import SwiftUI


 struct HighScoreView: View {
     @Environment(Player.self) var player
     
     
     // so the code below is how we can use bindable values while also using environment
     // this solution is ugly basically create a copy and then wrap it in a bindable property we can use, if we had used @State then this code would have been possible
     var body: some View {
         @Bindable var player = player
         
         Stepper("High Score:\(player.highScore)", value: $player.highScore)
     }
 }

 struct ContentView: View {
     @State private var player = Player()
     
     var body: some View {
         VStack{
             Text("Welcome!")
             HighScoreView()
         }
         .environment(player)
     }

 }

 #Preview {
     ContentView()
 }

 //Building a primary l ist of items
 */
