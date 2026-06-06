//
//  ContentView.swift
//  LayoutandGeometry
//
//  Created by Isidoro Flores on 6/1/26.
//

import SwiftUI

struct ContentView: View {
    // when we use frame(in: ) function swift ui will automatically calculate views current position in the  coordinate space we ask for and when we move the screen swift ui recaulculate this so that geometry reader stays updated'
    //so this effect below is cool but problamatic since the rotation makes the text readable at the rtop to fix this we need to use another geometry readfer
    // spinning helix effect at the bottom is what ive buikd
    
    let colors : [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    var body: some View {
      /*  GeometryReader{ fullView in
            ScrollView{
                ForEach(0..<50){ index in
                    GeometryReader{ proxy in
                        Text("Row # \(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(colors[index % 7])
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                        
                    }
                    .frame(height: 40)
                }
            }
        }
        */
        // Cover flow rotatiing triables
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 0){
                ForEach(1..<20){ num in
                    GeometryReader{ proxy in
                        Text("Number \(num)")
                            .font(.largeTitle)
                            .padding()
                            .background(.red)
                            //.rotation3DEffect(.degrees(proxy.frame(in: .global).minX / 8), axis: (x:0, y: 1, z: 0))
                            .frame(width: 200, height: 200)
                        //rewriting with visual effect
                            .visualEffect{ content, proxy in
                                content
                                    .rotation3DEffect(.degrees(proxy.frame(in: .global).minX) / 8, axis: ( x: 0, y : 1, z: 0) )
                            }
                        
                    }
                    .frame(width: 200, height: 200)
                    
                }
            
            }
            .scrollTargetLayout() // tells swift each text view is important or a target aka something important

        }
        .scrollTargetBehavior(.viewAligned) // this snapps a text view into place when ur done scrolling
    }
}


#Preview {
    ContentView()
}

/*
 how layouts work.
 they happen in three simple steps
 1 parent view proposes a size for a child
 w. the child then chooses tis specefic sixe
  parent view mus respect that cho ice
 3 the parent then assigns the child into a specefic coordinate space
 
 theres a fourth step behind the scenes, position and sizes are stored in decimals but swift rounds to the nearest whole number to keep our apps looking sharp
 
 How big is content view??
 Content view is **layout neutrol** whoch means it resizes itself depending on its body. so in the code provided below content view is the size of the text and background color nothing more and nothing less
 
 
 import SwiftUI

 struct ContentView: View {
     var body: some View {
         VStack {
             Text("Hello, world!")
                 .background(.red)
         }
     }
 }

 #Preview {
     ContentView()
 }
 
 // what happens when u apply a modifier to a view??
 
 well the view and the modifer get stored in a new view type called modified content and that modfied view  is on top of the  heiarchy
 
 so in the above code the background mdifer is on top and within that is the text view
 backgrounfs like content view are contennt neutral
 
 e put this into the three-step layout system, we end up with a conversation a bit like this:
 • SwiftUI: “Hey, ContentView, you have the whole screen to yourself – how much of it
 do you need?” (Parent view proposes a size)
 • ContentView: “I don’t care; I’m layout neutral. Let me ask my child: hey, background,
 you have the whole screen to yourself – how much of it do you need?” (Parent view
 proposes a size)
 • Background: “I also don’t care; I’m layout neutral too. Let me ask my child: hey, text,
 you can have the whole screen to yourself – how much of it do you need?” (Parent
 view proposes a size)
 • Text: “Well, I have the letters ‘Hello, World’ in the default font, so I need exactly X
 pixels width by Y pixels height. I don’t need the whole screen, just that.” (Child
 chooses its size.)
 • Background: “Got it. Hey, ContentView: I need X by Y pixels, please.”
 • ContentView: “Right on. Hey, SwiftUI: I need X by Y pixels.”
 • SwiftUI: “Nice. Well, that leaves lots of space, so I’m going to put you at your size in
 the center.” (Parent positions the child in its coordinate space.)
 
 
 so the code text("Hello world").background(.red) the tect view becomes a chi,d of the background view so this works from bottom to top
 
 what if we add padding becore the background color
 
 So, it’s more like this:
 • SwiftUI: You can have the whole screen, how much of it do you need, ContentView?
 • ContentView: You can have the whole screen, how much of it do you need,
 background?
 • Background: You can have the whole screen, how much of it do you need, padding?
 • Padding: You can have the whole screen minus 20 points on each side, how much of it
 do you need, text?
 • Text: I need X by Y.
 • Padding: I need X by Y plus 20 points on each side.
 • Background: I need X by Y plus 20 points on each side.
 • ContentView: I need X by Y plus 20 points on each side.
 • SwiftUI: OK; I’ll center you.
 
 
fects
 q if ur whole view heirchy is layout neutral itll take uop the entitr screen e
 
 so basically whith color.red it takes up the wholse space
 when it is inside the background modifer it asks text what size do u need text reutns size then it asks color.red whaot size doe that need and then color.red is layout neutral so it doesnt care and it takes up the size of the text view and so that is how that wokrs
 the second intersting side affect is if we use frame on an image that cant be reized we get a larger fram with the image inside not changing
 
 • ContentView offers the frame the whole screen.
 • The frame reports back that it wants 300x300.
 • The frame then asks the image inside it what size it wants.
 • The image, not being resizable, reports back a fixed size of 64x64 (for example).
 • The frame then positions that image in the center of itself.
 
 When you listen to Apple’s own SwiftUI engineers talk about modifiers, you’ll hear them
 often referred to as views – “the frame view”, “the background view”, and so on. I think that’s
 a great mental model to help understand exactly what’s going on: applying modifiers creates
 new views rather than just modifying existing views in-place
 
 
 Alignment and Alignmnet guide notes
 
 /
 //  ContentView.swift
 //  LayoutandGeometry
 //
 //  Created by Isidoro Flores on 6/1/26.
 //

 import SwiftUI

 struct ContentView: View {
     var body: some View {
         // a parent cant affect the childs size so the text will be inserted in the middle of the fframe
    /*     Text("Live long and prosper")
             .frame(width: 300, height: 300, alignment: .topLeading) // we changex the allignmnet or posistion
         
          You can then use offset(x:y:) to move the text around inside that frame.
          */
         // By default the code below is aligned in the center but we can tell our hstack how to align it
         // the bottom modfifer caused the text to align differently because each text size has a differnwt baseline
         /*
          Fortunately, SwiftUI has two special alignments that align text on the baseline of either the
          first child or the last child. This will cause all views in a stack to be aligned on a single unified
          baseline, regardless of their font
          
         HStack(alignment: .lastTextBaseline){
             Text("Live")
                 .font(.caption)
             Text("Long")
             Text("and")
                 .font(.title)
             Text("Prosper")
                 .font(.largeTitle)
          }
          
         
         //For more fine grained control we can customize what al    ignmnet means for each individual view
         
         VStack(alignment: .leading){
             Text("Hello, world!")
             Text("this is a longer line of text")
         }
         .background(.red)
         .frame(width: 400, height: 400)
         .background(.blue)
             
          
         
         VStack(alignment: .leading){
             Text("Hello world")
                 .alignmentGuide(.leading){ d in d[.trailing] }
             Text("This is a longer line of text")
         }*/
         VStack(alignment: .leading){
             ForEach(0..<10){ position in
                 Text("Number\(position)")
                     .alignmentGuide(.leading){_ in Double(position) * -10}
             }
         }
         .background(.red)
         .frame(width: 400, height: 400)
         .background(.blue)
     }
 }

 #Preview {
     ContentView()
 }

 //////////////// How to create a custom alignmnet guide
 
 
 import SwiftUI
 // we need a custom alignmnet tyupe to get this to align we will use enums
 // the alignment id protocol required a defaultvalue in method that accepts a view dimendion and outputs a cgfloat
 // remember alignment guide is a guide on a line and we still need to specify position within that alignmnet guide
 // we can create an instance of a struct but n this case it doesnt mean anything so an enum is prefeered because we lose that functionlity and our code becomes clear that htis hold some functinality
 extension VerticalAlignment {
     struct MidAccountAndName : AlignmentID {
         static func defaultValue(in context: ViewDimensions) -> CGFloat {
             context[.top]
         }
     }
     
     static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
 }

 struct ContentView: View {
     var body: some View {
         HStack(alignment: .midAccountAndName){
             VStack{
                 Text("@isiflo28")
                     .alignmentGuide(.midAccountAndName){ d in
                         d[VerticalAlignment.center]}
                 Image(.headshot)
                     .resizable()
                     .frame(width: 64, height: 64)
             }
             VStack{
                 Text("Full name:")
                 Text("Isidoro Flores")
                     .alignmentGuide(.midAccountAndName){ d in
                         d[VerticalAlignment.center]}
                     .font(.largeTitle)
             }
         }
     }
 }

 #Preview {
     ContentView()
 }
 
 
 /////////////////Absolute positioning of swiftui views
 /
 //  ContentView.swift
 //  LayoutandGeometry
 //
 //  Created by Isidoro Flores on 6/1/26.
 //

 import SwiftUI
 // position in swift ui
 // swiftui gives us two tools for positioning, absolute positioning using position() and relativer positioning with offset

 struct ContentView: View {
     var body: some View {
         Text("Hello World")
            // .position(x: 100 , y: 100)
             .offset(x: 100 , y: 100)
             .background(.red)
         // with offset were not chnaging the underlying geometry so when we use it references where the text was and highlights that
         //the above code is an example of absolute positioning
         // why is the entire view red? because remember the chi ld doesnt determine position the parent does so when we use the modifer poisiton a nrew view is ccreared hwoch then allows us to position the text into that view
     }
 }
//////////// resiszing images to fit the screen using geometry reade r
 
 
 
 struct ContentView: View {
     var body: some View {
         //sO HOW DOES THIS Differe from relative frame??
         //rleative fram has very percise definitions of what is consifered a frame
         // SCREE NAVSTACK LIST AND SCroll view
         // so an imamge embededded in a vstack or hstack will ignore the hstack when ussing relative frame
         
         HStack{
             Text("IMPORTANT")
                 .frame(width: 200)
                 .background(.blue)
             GeometryReader{ proxy in
                 Image(.headshot)
                     .resizable()
                     .scaledToFit()
                     .frame(width: proxy.size.width * 0.8)
                     .frame(width: proxy.size.width, height: proxy.size.height)
                 
             }
         }
     }
 }

 ////////////////// Understanding frames and coordinates inside of geometry reader
 hose sizes are mostly different, so hopefully you can see the full range of how these frame
 work:
 • A global center X of 191 means that the center of the geometry reader is 191 points
 from the left edge of the screen.
 • A global center Y of 440 means the center of the geometry reader is 440 points from
 710
 www.hackingwithswift.com
 Understanding frames and coordinates inside GeometryReader
 the top edge of the screen. This isn’t dead in the center of the screen because there is
 more safe area at the top than the bottom.
 • A custom center X of 191 means the center of the geometry reader is 191 points from
 the left edge of whichever view owns the “Custom” coordinate space, which in our
 case is OuterView because we attach it in ContentView. This number matches the
 global position because OuterView runs edge to edge horizontally.
 • A custom center Y of 381 means the center of the geometry reader is 381 points from
 the top edge of OuterView. This value is smaller than the global center Y because
 OuterView doesn’t extend into the safe area.
 • A local center X of 153 means the center of the geometry reader is 153 points from the
 left edge of its direct container.
 • A local center Y of 350 means the center of the geometry reader is 350 points from the
 top edge of its direct container.
 Which coordinate space you want to use depends on what question you want to answer:
 • Want to know where this view is on the screen? Use the global space.
 • Want to know where this view is relative to its parent? Use the local space.
 • What to know where this view is relative to some other view? Use a custom space.
 //
 //  ContentView.swift
 //  LayoutandGeometry
 //
 //  Created by Isidoro Flores on 6/1/26.
 //

 import SwiftUI

 struct OuterView: View {
     var body: some View {
         VStack{
             Text("Top")
             InnerView()
                 .background(.green)
             Text("Bottom")
         }
     }
 }
 struct InnerView: View {
     var body: some View {
         HStack{
             Text("Left")
             GeometryReader{ proxy in
                 Text("Center")
                     .background(.blue)
                     .onTapGesture{
                         print("Global center: \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY)")
                         print("Custom center: \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY)")
                         print("Local Center: \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY)")
                     }
             }
             .background(.orange)
             Text("Right")
         }
     }
 }

 struct ContentView: View {
     var body: some View {
         // Geometry reader has flexible size which means itll expand to take up more soace
     /*    VStack{
             GeometryReader{ proxy in
                 Text("Hello world")
                 // we can make a text view take up 90 percent of the screen width regardless of content with this code
                 // the proxy parameter contains the proposed size of the parent/ plus a method that reads fram values
                     .frame(width: proxy.size.width * 0.9, height: 40)
                     .background(.red)
                 
             }
             .background(.green)
             Text("More text here for example")
                 .background(.blue)
         }
      */
     OuterView()
             .background(.red)
             .coordinateSpace(name: "Custom")
     }
 }
 
 claude when u add this to my website can u render an example of the above code thanks
///////////////////////// SCROLL VIEW AFECTS USING GEOMETRY READER
 //
 //  ContentView.swift
 //  LayoutandGeometry
 //
 //  Created by Isidoro Flores on 6/1/26.
 //

 import SwiftUI

 struct ContentView: View {
     // when we use frame(in: ) function swift ui will automatically calculate views current position in the  coordinate space we ask for and when we move the screen swift ui recaulculate this so that geometry reader stays updated'
     //so this effect below is cool but problamatic since the rotation makes the text readable at the rtop to fix this we need to use another geometry readfer
     // spinning helix effect at the bottom is what ive buikd
     
     let colors : [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
     var body: some View {
       /*  GeometryReader{ fullView in
             ScrollView{
                 ForEach(0..<50){ index in
                     GeometryReader{ proxy in
                         Text("Row # \(index)")
                             .font(.title)
                             .frame(maxWidth: .infinity)
                             .background(colors[index % 7])
                             .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                         
                     }
                     .frame(height: 40)
                 }
             }
         }
         */
         // Cover flow rotatiing triables
         ScrollView(.horizontal, showsIndicators: false){
             HStack(spacing: 0){
                 ForEach(1..<20){ num in
                     GeometryReader{ proxy in
                         Text("Number \(num)")
                             .font(.largeTitle)
                             .padding()
                             .background(.red)
                             .rotation3DEffect(.degrees(proxy.frame(in: .global).minX / 8), axis: (x:0, y: 1, z: 0))
                             .frame(width: 200, height: 200)
                         
                     }
                     .frame(width: 200, height: 200)
                 }
             }
         }
     }
 }
/////////////////SCROLL VIEW EFFECTS USING VisualEffect() and scrollTargetBehavior()
 */
