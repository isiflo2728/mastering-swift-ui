//
//  DetailView.swift
//  BookWorm
//
//  Created by Isidoro Flores on 5/15/26.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let book : Book
    var body: some View {
        ScrollView {
        ZStack(alignment: .bottomTrailing) {
        Image(book.genre)
        .resizable()
        .scaledToFit()
        Text(book.genre.uppercased())
        .font(.caption)
        .fontWeight(.black)
        .padding(8)
        .foregroundStyle(.white)
        .background(.black.opacity(0.75))
        .clipShape(.capsule)
        .offset(x: -5, y: -5)
        }
            Text(book.author)
            .font(.title)
            .foregroundStyle(.secondary)
            Text(book.review)
            .padding()
            RatingView(rating: .constant(book.rating))
            .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    //to create sample book object we must first scread our model contex t by creating a model container
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "TestBook",author: "TestAuthor", genre: "Fantasy", review: "This was a great book; Ireally enjoyed it.", rating: 4)
        
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
