//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Isidoro Flores on 5/22/26.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        Button("Tap me"){
            print("Button tapped")
            // user can say press tap me and siwft will react but what if the button has a more complex name to it
        }.accessibilityInputLabels(["Button", "Me", "Tap Tape"]) // these allow mem to choose a variety of different speech labels a user can use to perform an action
        
    }
}

#Preview {
    ContentView()
}


/**
 Beyond setting labels and hints, there are several ways we can control what VoiceOver reads
 out. There are three in particular I want to focus on:
 • Marking images as being unimportant for VoiceOver.
 • Hiding views from the accessibility system.
 • Grouping several views as one.
 
 
 Image(decorative: "character")
 
 
 u can hide accesbility Image(.character)
 .accessibilityHidden(true) only use this if view provides no meaningful information
 
 The last way to hide content from VoiceOver is through grouping, which lets us control how
 the system reads several views that are related. As an example, consider this layout:
 VStack {
 Text("Your score is")
 Text("1000")
 .font(.title)
 }
 VoiceOver sees that as two unrelated text views, and so it will either read “Your score is” or
 “1000” depending on what the user has selected. Both of those are unhelpful, which is where
 the .accessibilityElement(children:) modifier comes in: we can apply it to a parent view, and
 ask it to combine children into a single accessibility element.
 For example, this will cause both text views to be read together, with a short pause between
 them:
 VStack {
 Text("Your score is")
 Text("1000")
 .font(.title)
 }
 .accessibilityElement(children: .combine)
 That works really well when the child views contain separate information, but in our case the
 children really should be read as a single entity. So, the better solution here is to
 use .accessibilityElement(children: .ignore) so the child views are invisible to VoiceOver,
 then provide a custom label to the parent, like this:
 VStack {
 Text("Your score is")
 Text("1000")
 .font(.title)
 }
 .accessibilityElement(children: .ignore)
 .accessibilityLabel("Your score is 1000")
 It’s worth trying both of these to see how they differ in practice. Using
 
 
 import SwiftUI

 struct ContentView: View {
     let pictures =  [
         "ales-krivec-15949",
         "galina-n-189483",
         "kevin-horstmann-141705",
         "nicolas-tissot-335096"
         ]
     let labels = [
         "Tulips",
         "Frozen tree buds",
         "Sunflowers",
         "Fireworks",
     ]
     @State private var selectedPicture = Int.random(in: 0...3)
     var body: some View {
        Image(pictures[selectedPicture])
             .resizable()
             .scaledToFit()
             .onTapGesture {
                 selectedPicture = Int.random(in: 0...3)
             }
             .accessibilityLabel(labels[selectedPicture])//one word description
             .accessibilityAddTraits(.isButton)// on tap gesutre is oiur button
             .accessibilityRemoveTraits(.isImage)//removes is image trait
     }
 }

 #Preview {
 
 ////////Reading value of controls ////////////////
 import SwiftUI

 struct ContentView: View {
 @State private var value = 10
     var body: some View {
         VStack{
             Text("Value \(value)")
             
             Button("Increment"){
                 value += 1
             }
             
             Button("Decrement"){
                 value -= 1
             }
         }.accessibilityElement()
             .accessibilityLabel("Value")
             .accessibilityValue(String(value))
             .accessibilityAdjustableAction { direction in
                 switch direction {
                 case .increment:
                     value += 1
                 case .decrement:
                     value -= 1
                 default:
                     print("Not handled")
                 }
             }
         // This allows users to select the whole vstack learn the value and then swipe up and down to increment or decrement the value
         
         
     }
 }

 #Preview {
     ContentView()
 }

///////////////Handling Voice INput in swiftUI
 
 mport SwiftUI

 struct ContentView: View {

     var body: some View {
         Button("Tap me"){
             print("Button tapped")
             // user can say press tap me and siwft will react but what if the button has a more complex name to it
         }.accessibilityInputLabels(["Button", "Me", "Tap Tape"]) // these allow mem to choose a variety of different speech labels a user can use to perform an action
         
     }
 }

 #Preview {
     ContentView()
 }
 */
