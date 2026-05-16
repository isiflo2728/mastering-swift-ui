//
//  RatingView.swift
//  BookWorm
//
//  Created by Isidoro Flores on 5/15/26.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating : Int
    var lable = ""
    var maxRating = 5
    var offImage : Image?
    var onImage =  Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    
    
    var body: some View {
        HStack {
            if lable.isEmpty == false{
                Text(lable)
            }
            ForEach(1..<maxRating, id : \.self){ number in
                Button {
                    rating = number
                } label : {
                    image(for : number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
                .buttonStyle(.plain)
                
            }
        }
    }
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        }
        else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
