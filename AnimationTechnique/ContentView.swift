//
//  ContentView.swift
//  AnimationTechnique
//
//  Created by Isidoro Flores on 4/24/26.
//

import SwiftUI

struct cornerRotateModifier: ViewModifier{
    let amount : Double
    let anchor : UnitPoint
    
    func body(content: Content) -> some View{
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition {
        .modifier(
            active: cornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: cornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    
    @State private var isShowingRed = false
    
    var body : some View{
       
        ZStack{
          Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            if isShowingRed{
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation{
                isShowingRed.toggle()
            }
        }
        
    }
}

#Preview {
    ContentView()
}

/*
 //////////////////////////////CUSTOMIZING ANIMATIONS//////////////////////////
 Button("Tap me"){
 // animationAmount += 1
}

.padding(50)
.background(.red)
.foregroundStyle(.white)
.clipShape(.circle)
//.blur(radius: (animationAmount - 1) * 3)
//.scaleEffect(animationAmount)
//.animation(.linear, value: animationAmount)
// .animation(.spring(duration: 1, bounce: 0.9), value: animationAmount)
.overlay{
 Circle()
     .stroke(.red)
     .scaleEffect(animationAmount)
     .opacity(2 - animationAmount)
     .animation(.easeOut(duration: 1).repeatForever(autoreverses: false),value : animationAmount)
}
.onAppear{
 animationAmount = 2
}
 @State private var animationAmount = 1.0
 
 print(animationAmount)
 return VStack {
    
     Stepper("Scale Amount", value: $animationAmount.animation(), in : 1...10)
     
     Spacer()
     
     Button("Tap me"){
         animationAmount += 1
     }
     .padding(40)
     .background(.red)
     .foregroundStyle(.white)
     .clipShape(.circle)
     .scaleEffect(animationAmount)

 }
 
 
  Button("Tap me"){
      withAnimation(.spring(duration: 1, bounce: 0.5)){
          animationAmount += 360
      }
  }
  .padding(50)
  .background(.red)
  .foregroundStyle(.white)
  .clipShape(.circle)
  .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
  
  // gonna use this modifier rotation3DEffect which can be given an axis and a rotation amount \
 
 //Animaiton modifier, order matters as well 3
 @State private var enabled = false
    Button("Tap me"){
        enabled.toggle()
    }
    .background(.blue)
    .frame(width: 200, height: 200)
    .foregroundStyle(.white)
    
    Button("Tap me"){
        enabled.toggle()
    }
    .frame(width: 200, height: 200)
    .background(enabled ? .red : .blue)
    .animation(nil, value: enabled)
        .foregroundStyle(.white)

        .clipShape(.rect(cornerRadius: enabled ? 60: 0))
        .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
 
 @State private var dragAmount = CGSize.zero
 LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
     .frame(width: 300, height: 200)
     .clipShape(.rect(cornerRadius: 10))
     .offset(dragAmount)
   // drage gesture lets us run a closure for when user finger is on screne and for when finger is off screen
     .gesture(
         DragGesture()
             .onChanged{dragAmount = $0.translation}
             .onEnded{_ in
                 
                 withAnimation(.bouncy) {
                     dragAmount = .zero
                 }}
     )
 
 VStack {
     Button("Tap me"){
         withAnimation{
             isShowingRed.toggle()
         }
     }
     
     if isShowingRed {
         Rectangle()
             .fill(.red)
             .frame(width: 200, height: 200)
             .transition(.asymmetric(insertion: .scale, removal: .opacity))
     }
 }
 
 
 */

