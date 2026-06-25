//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Isidoro Flores on 6/23/26.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort
    var body: some View {
        Group{
            VStack{
                Text("Elavation")
                    .font(.caption.bold())
                Text("\(resort.elevation)m")
                    .font(.title3)
                
            }
            
            VStack{
                Text("Snow")
                    .font(.caption.bold())
                Text("\(resort.snowDepth)m")
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
        
    }
}

#Preview {
    SkiDetailsView(resort: .example)
}
