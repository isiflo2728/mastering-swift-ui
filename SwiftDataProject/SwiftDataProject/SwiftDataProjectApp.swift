//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Isidoro Flores on 5/16/26.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for : User.self)
    }
}
