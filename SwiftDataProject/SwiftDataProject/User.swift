//
//  User.swift
//  SwiftDataProject
//
//  Created by Isidoro Flores on 5/16/26.
//

import Foundation
import SwiftData


@Model
class User {
    var name : String = "Anonymous"
    var city : String = "Unknown"
    var joinDate : Date = Date.now
    @Relationship(deleteRule: .cascade) var jobs: [Job]?  = [Job]()
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}

@Model
class Job {
    var name : String = "None"
    var priority : Int = 1
    var owner : User?
    
    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}

/*Even better, the next time our app launches SwiftData will silently add the jobs property to all
 its existing users, giving them an empty array by default. This is called a migration: when we
 add or delete properties in our models, as our needs evolve over time. SwiftData can do simple
 migrations like this one automatically, but as you progress further you'll learn how you can
 create custom migrations to handle bigger model changes.
 
 Tip: When we used the modelContainer() modifier in our App struct, we passed in User.self
 so that SwiftData knew to set up storage for that model. We don't need to add Job.self there
 because SwiftData can see there's a relationship between the two, so it takes care of both
 
 To use cloud kit model data must be optional or initialized with default values
 
 ⏺ This goes inside your User model class in User.swift:

   @Model
   class User {
       var name: String
       var city: String
       var joinDate: Date
       var jobs: [Job]?

       var unwrappedJobs: [Job] {
           jobs ?? []
       }
   
       init(name: String, city: String, joinDate: Date) {
           self.name = name
           self.city = city
           self.joinDate = joinDate
       }
   }

   Then everywhere in your views you use user.unwrappedJobs instead of user.jobs and never have to deal with the optional.

 ✻ Baked for 4s
   
 ❯ how do i make it read only

 ⏺ It already is — computed properties with only a getter (no set) are read-only by default. Since unwrappedJobs only has the get body with no set block, Swift automatically makes it read-only.


 */
