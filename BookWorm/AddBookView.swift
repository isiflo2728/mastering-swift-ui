//
//  AddBookView.swift
//  BookWorm
//
//  Created by Isidoro Flores on 5/15/26.
//

import SwiftUI
import SwiftData

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss)  var dismiss
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var rating: Int = 3
    @State private var genre: String = "Fantasy"
    @State private var review: String = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack{
            Form {
                Section{
                    TextField("Name of Book", text : $title)
                    TextField("Authors name", text : $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                        
                    }
                }
                
                Section("Write a review"){
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                Section{
                    Button("Save"){
                        let newbook = Book(title: title, author: author, genre: genre,review : review, rating: rating)
                        modelContext.insert(newbook)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
