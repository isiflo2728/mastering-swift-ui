//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Isidoro Flores on 5/27/26.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
