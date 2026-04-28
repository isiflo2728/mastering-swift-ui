//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Isidoro Flores on 4/27/26.
//

import Foundation
// Identifiable needs one uniquew property to be able to conform to it and we have that with id
// why add this?? it makes our foreach code less complez
struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name : String
    let type : String
    let amount : Double
    
}

@Observable
class Expenses {
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from : savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}
