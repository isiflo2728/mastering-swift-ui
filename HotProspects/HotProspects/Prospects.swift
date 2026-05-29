//
//  Prospects.swift
//  HotProspects
//
//  Created by Isidoro Flores on 5/27/26.
//

import SwiftData

@Model
class Prospect {
    var name : String
    var emailAddress: String
    var isContacted : Bool
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}

// remember the @model macro can only be used with clases but that lets us keep our data updatedad across views


