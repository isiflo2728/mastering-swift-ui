//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Isidoro Flores on 5/14/26.
//

import SwiftUI
import SwiftData

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self) // modifieer to make our data availible throughout the app
        //when app first runs it creates databsefile after it doesnt and loads the database
        
    }
}
// Once data is defined we need to write some code to load the model and tell swift data to prepare some space on the iphone to reaad and write from
// every swift model needs model context think of it as allowing us to modify the data live which is much faster than reading and writing
/*
 we query to retrieve data what we want how it should be sorted and ii any filters should be used
 we need to keep data up to date to match u views as well e

 swift soultion to this is @Querry which is available to us after mporting swift data 
 */
