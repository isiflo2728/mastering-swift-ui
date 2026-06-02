//
//  ContentView.swift
//  FlashZilla
//
//  Created by Isidoro Flores on 5/29/26.
//

import SwiftUI
import Foundation
internal import Combine


extension View {
    /*As you can see, that pushes views down by 10 points for each place they are in the array: 0,
     then 10, 20, 30, and so on*/
    func stacked(at position: Int, in total: Int) -> some View{
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    @State private var cards = Array<Card>()
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @State private var timeRemaining = 100
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityWithVoiceOverEnabled
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var showingEditScreen = false
    
    
    var body: some View {
        ZStack{
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                
            Text("Time Remaining: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                ZStack{
                    VStack{
                        HStack{
                            Spacer()
                            
                            Button{
                                showingEditScreen = true
                            } label : {
                                Image(systemName: "plus.circle")
                                    .padding()
                                    .background(.black.opacity(0.7))
                                    .clipShape(.circle)
                                    .clipShape(.circle)
                            }
                        }
                        Spacer()
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .padding()
                    }
                    if accessibilityDifferentiateWithoutColor || accessibilityWithVoiceOverEnabled {
                        VStack{
                            Spacer()
                            
                            HStack{
                                Button{
                                    withAnimation{
                                        removeCard(at: cards.count - 1)
                                    }
                                } label : {
                                    Image(systemName: "xmark.circle")
                                        .padding()
                                        .background(.black.opacity(0.75))
                                        .clipShape(.circle)
                                }
                                .accessibilityLabel("Wrong")
                                .accessibilityHint("Mark your Answer as being incorrect")
                                
                                Spacer()
                                
                                Button {
                                    withAnimation{
                                        removeCard(at: cards.count - 1)
                                    }
                                } label : {
                                    Image(systemName: "checkmark.circle")
                                        .padding()
                                        .background(.black.opacity(0.75))
                                        .clipShape(.circle)
                                }
                                .accessibilityLabel("Correct")
                                .accessibilityHint("Mark your answer as being correct")
                            }
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .padding()
                        }
                    }
                    ForEach(0..<cards.count, id: \.self){ index in
                        CardView(card: cards[index]){
                            withAnimation{
                                removeCard(at: index)
                                if cards.isEmpty {
                                    isActive = false
                                }
                            }
                        }
                            .stacked(at: index, in: cards.count)
                            .allowsTightening(index == cards.count - 1)
                            .accessibilityHidden(index < cards.count - 1)
                        
                        
                    }
                }.allowsHitTesting(timeRemaining > 0)
                if cards.isEmpty {
                    Button("Restart", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCardsView.init)
        .onAppear(perform: resetCards)
        .onReceive(timer){ time in
            guard isActive else { return }
            
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
            
        }
        .onChange(of: scenePhase){
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
    }
    
    func removeCard(at index: Int){
        guard index >= 0 else { return }
        cards.remove(at: index)
    }
    func resetCards() {
       
        timeRemaining = 100
        isActive = true
       loadData()
    }
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards"){
            if let decoded = try? JSONDecoder().decode([Card].self, from: data){
                cards = decoded
            }
        }
    }
}

#Preview {
    ContentView()
}
/*     VStack {
 //DragGesture, LongPressGesture, MagnifyGesture, RotateGesture, andTapGesture.
Text("Hello, world!")
     .onLongPressGesture(minimumDuration: 1){
         print("Long Presserd!")
     } onPressingChanged: { inProgress in
         print("In progress: \(inProgress)")
     }
}
 ////////////////////////
 How to pinch and zoom a view
 //
 //  ContentView.swift
 //  FlashZilla
 //
 //  Created by Isidoro Flores on 5/29/26.
 //

 import SwiftUI

 struct ContentView: View {
     // Learning how to modify a view with pinch to zoom
     @State private var currentAmount = 0.0
     @State private var finalAmount = 1.0
     var body: some View {
  
         VStack {
        Text("Hello world")
                 .scaleEffect(finalAmount + currentAmount)
                 .gesture(
                     MagnifyGesture()
                         .onChanged{ value in
                             currentAmount = value.magnification - 1
                         }
                         .onEnded{ value in
                             finalAmount += currentAmount
                          currentAmount = 0
                         }
                 )
         }
     
     }
 }
 
 
 /// how to rotate a view
 //
 //  ContentView.swift
 //  FlashZilla
 //
 //  Created by Isidoro Flores on 5/29/26.
 //

 import SwiftUI

 struct ContentView: View {
     // Learning how to modify a view with pinch to zoom
     @State private var currentAmount = Angle.zero
     @State private var finalAmount = Angle.zero
     var body: some View {
  
         VStack {
        Text("Hello world")
                 .rotationEffect(finalAmount + currentAmount)
                 .gesture(
                     RotateGesture()
                         .onChanged{ value in
                             currentAmount = value.rotation
                         }
                         .onEnded{ value in
                             finalAmount += currentAmount
                             currentAmount = .zero
                         }
                 )
         }
     
     }
 }
 // below or my notes on how to hnadle competing gestures
 struct ContentView: View {
   // learning about competing views
     //in the following code the child will always get priorityu so the text tapped par
     var body: some View {
  
         VStack{
             Text("Hello world")
                 .onTapGesture {
                     print("Text tapped")
                 }
         }
         .onTapGesture {
             print("VStack tapped")
         }
     
     }
 }

 //
 //  ContentView.swift
 //  FlashZilla
 //
 //  Created by Isidoro Flores on 5/29/26.
 //

 import SwiftUI

 struct ContentView: View {
   // learning about competing views
     //in the following code the child will always get priorityu so the text tapped par
     // to get parent to register its gesture u need to duse high prority gesture
     // u can use the simultaneous gesture to get both to work at the same tim e
     var body: some View {
  
         VStack{
             Text("Hello world")
                 .onTapGesture {
                     print("Text tapped")
                 }
         }
         .simultaneousGesture(
             TapGesture()
                 .onEnded {
                     print("VStack tapped")
                 }
         )
     
     }
 }

 #Preview {
     ContentView()
 }
 ////////////////////gesture sequencing////////////////
 //
 //  ContentView.swift
 //  FlashZilla
 //
 //  Created by Isidoro Flores on 5/29/26.
 //

 import SwiftUI

 struct ContentView: View {
   
     // how far the circle has been dragged
            @State private var offSet = CGSize.zero
            //tracking if it is being dragged
        @State private var isDragging = false
     var body: some View {
 //A drag gesture that updates offset and isdraggign as it is being moved around
         let dragGesture = DragGesture()
             .onChanged{ value in offSet = value.translation}
             .onEnded{ _ in
                 withAnimation{
                     offSet = .zero
                     isDragging = false
                 }
             }
         //Long press gesture that enables dragging
         let pressGesture = LongPressGesture()
             .onEnded{ value in
                 withAnimation{
                     isDragging = true
                 }
             }
         // combined gesture forcess users to long press then drag
         let combined = pressGesture.sequenced(before: dragGesture)
         
         Circle()
             .fill(.red)
             .frame(width: 64, height: 64)
             .scaleEffect(isDragging ? 1.5 : 1)
             .offset(offSet)
             .gesture(combined)
         
     }
 }
///// disabling user interactivity with allowsHittesting()
 
 ZStack{
     Rectangle()
         .fill(.blue)
         .frame(width: 300, height: 300)
         .onTapGesture{
             print("Rectangle tapped")
         }
     Circle()
         .fill(.red)
         .frame(width: 300, height: 300)
         .contentShape(.rect)
         .onTapGesture{
             print("Circle tapped")
         }
     
 }
 // Hello world will be interactive but the space betwen em wont be tapable
   var body: some View {
       VStack{
           Text("Hello")
           Spacer().frame(height: 100)
           Text("World")
           
       }.contentShape(.rect)
       .onTapGesture {
           print("Vstack tapped")
       }
   }
}
 
 ///////////////////////Timer and publishers
 let timer = Timer.publish(every: 1, on: .main,
 in: .common).autoconnect()
 2. 3. 4. 5. It asks the timer to fire every 1 second.
 It says the timer should run on the main thread.
 It says the timer should run on the common run loop, which is the one you’ll want to
 use most of the time. (Run loops let iOS handle running code while the user is actively
 doing something, such as scrolling in a list.)
 It connects the timer immediately, which means it will start counting time.
 It assigns the whole thing to the timer constant so that it stays alive.
 
 import SwiftUI
 import Foundation
 internal import Combine
 // We can use timers to execute blocks of code after a few number of seconds, if we use Combine we can make timers into publishers whih are things that annunce when their value changes

 struct ContentView: View {
     let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
     @State private var counter = 0
     
     var body: some View {
         Text("Hello world!")
             .onReceive(timer){ time in
                 if counter == 5{
                     timer.upstream.connect().cancel()
                 } else {
                     print("The time is now \(time)")
                 }
                 counter += 1
             }
     }
 }

 #Preview {
     ContentView()
 }
 
 
 // Swiftui lets us detect when our app was moved to the background or not
 Adding a new property to watch an environment value called scenePhase.
 Using onChange() to watch for the scene phase changing.
 Responding to the new scene phase somehow.
 //
 //  ContentView.swift
 //  FlashZilla
 //
 //  Created by Isidoro Flores on 5/29/26.
 //

 import SwiftUI
 import Foundation
 internal import Combine
 // We can use timers to execute blocks of code after a few number of seconds, if we use Combine we can make timers into publishers whih are things that annunce when their value changes

 struct ContentView: View {
     @Environment(\.scenePhase) var scenePhase
     var body: some View {
         Text("Hello world")
             .onChange(of: scenePhase) { oldPhase, newPhase in
                 if newPhase == .active {
                     print("Active")
                 } else if newPhase == .inactive {
                     print("Inactive")
                 } else if newPhase == .background {
                     print("Bakcground")
                 }
             }
     }
 }

 #Preview {
     ContentView()
 }
 
 Active scenes are running right now, which on iOS means they are visible to the user.
On macOS an app’s window might be wholly hidden by another app’s window, but
that’s okay – it’s still considered to be active.
• Inactive scenes are running and might be visible to the user, but the user isn’t able to
access them. For example, if you’re swiping down to partially reveal the control center
then the app underneath is considered inactive.
• Background scenes are not visible to the user, which on iOS means they might be
terminated at some point in the future.
 
 ///// how to makr views more accesible with people that suffer from  color blindness
 
 //
 //  ContentView.swift
 //  FlashZilla
 //
 //  Created by Isidoro Flores on 5/29/26.
 //

 import SwiftUI
 import Foundation
 internal import Combine


 struct ContentView: View {
     @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
     
     var body: some View {
         HStack{
             if differentiateWithoutColor{
                 Image(systemName: "checkmark.circle")
             }
             Text("Success")
         }
         .padding()
         .background(differentiateWithoutColor ? .black : .green)
         .foregroundStyle(.white)
         .clipShape(.capsule)
     }
 }e
 
 we can also reduce motion  with an environment vatiable
 
 
 we can add a wrapper function to reduce our code
 func withOptionalAnimation<Result>(_
 animation: Animation?
 =
 .default,
 _ body: () throws -> Result) rethrows -> Result {
 if UIAccessibility.isReduceMotionEnabled {
 return try body()
 } else {
 return try withAnimation(animation, body)
 }
 }  and trhen our body code changes like this
 struct ContentView: View {
 @State private var scale = 1.0
 var body: some View {
 Button("Hello, World!") {
 withOptionalAnimation {
 644
 www.hackingwithswift.com
 Supporting specific accessibility needs with SwiftUI
 scale *= 1.5
 }
 }
 .scaleEffect(scale)
 }
 }
 
 this way we dont repeat animation code all the time and it becomes single shot
 
 
 //  ContentView.swift
 //  FlashZilla
 //
 //  Created by Isidoro Flores on 5/29/26.
 //

 import SwiftUI
 import Foundation
 internal import Combine


 struct ContentView: View {
     @Environment(\.accessibilityReduceMotion) var reduceMotion
     @State private var scale = 1.0
     
     var body: some View {
         Button("Hello world"){
             if reduceMotion {
                 scale *= 1.5
             } else {
                 withAnimation{
                     scale *= 1.5
                 }
             }
         }
         .scaleEffect(scale)
     }
 }

 #Preview {
     ContentView()
 }
 */
