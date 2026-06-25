//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Isidoro Flores on 6/25/26.
//

import Foundation

@Observable
class Favorites {
    private var resorts: Set<String>
    
    private let key = "favorites"
    
    
    init(){
        // Load Our Saved Data
        
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        
         resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort){
        resorts.insert(resort.id)
        save()
        
    }
    func remove (_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save (){
        // save data
        
    }
    
    
}
