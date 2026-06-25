//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Isidoro Flores on 6/23/26.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(Favorites.self) var favorites
    
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0){
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFill()
                HStack{
                    if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                        
                        VStack(spacing: 10){ResortDetailsView(resort: resort)}
                        VStack(spacing: 10){ SkiDetailsView(resort: resort)}
                        
                    } else{
                        
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                Group{
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilitie")
                        .font(.headline)
                    HStack{
                        ForEach(resort.facilityTypes){ facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                                
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                            
                        }
                    }
                        .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility){ _ in
            
        } message : { Facility in
            Text(Facility.description)
        }
        
        
        Button(favorites.contains(resort) ? "Remove From Favorites?" : "Add to favorites"){
            if favorites.contains(resort){
                favorites.remove(resort)
            } else {
                favorites.add(resort)
            }
        }
        .buttonStyle(.borderedProminent)
        .padding()
    }
}

#Preview {
    ResortView(resort: .example)
        .environment(Favorites())
}

