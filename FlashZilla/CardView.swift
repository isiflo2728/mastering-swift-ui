//
//  CardView.swift
//  FlashZilla
//
//  Created by Isidoro Flores on 5/29/26.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal : (() -> Void)? = nil
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor ? .white : .white .opacity(1 - Double(abs(offset.width / 50)))
                    .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    accessibilityDifferentiateWithoutColor ? nil : RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius: 10)
            VStack{
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    if isShowingAnswer{
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                            
                    }
                }
                
               
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: 450, maxHeight: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width)
        .accessibilityAddTraits(.isButton)
        
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.bouncy, value: offset)
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        removal?()
                        
                    } else {
                        offset = .zero
                    }
                }
        )

    }
}

#Preview {
    CardView(card: .example)
}
