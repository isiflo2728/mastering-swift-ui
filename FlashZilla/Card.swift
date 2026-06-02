//
//  Card.swift
//  FlashZilla
//
//  Created by Isidoro Flores on 5/29/26.
//

import Foundation

struct Card: Codable {
    var prompt : String
    var answer : String
    
    static let example = Card(prompt: "Who played the 13th doctor in Dr. Who", answer: "Jodie Whittakar")
}
