//
//  Mission.swift
//  MoonShot
//
//  Created by Isidoro Flores on 4/28/26.
//

import Foundation



struct Mission : Codable , Identifiable {
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    
    struct CrewRole : Codable {
        let name : String
        let role : String
        
    }
    let id : Int
    let launchDate: Date?
    let crew : [CrewRole]
    let description : String
    
    struct CrewMember {
        let role : String
        let astronaut : Astronaut

    }
    
}
