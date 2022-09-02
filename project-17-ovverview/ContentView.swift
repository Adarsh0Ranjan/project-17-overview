//
//  ContentView.swift
//  project-17-ovverview
//
//  Created by Roro Solutions on 31/08/22.
//

import SwiftUI
//lecture-8-accesiblity
//struct ContentView: View {
//    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
//
//    var body: some View {
//        HStack {
//            if differentiateWithoutColor {
//                Image(systemName: "checkmark.circle")
//            }
//
//            Text("Success")
//        }
//        .padding()
//        .background(differentiateWithoutColor ? .black : .green)
//        .foregroundColor(.white)
//        .clipShape(Capsule())
//    }
//}

//struct ContentView: View {
//    @Environment(\.accessibilityReduceMotion) var reduceMotion
//    @State private var scale = 1.0
//
//    var body: some View {
//        Text("Hello, World!")
//            .scaleEffect(scale)
//            .onTapGesture {
//                if reduceMotion {
//                    scale *= 1.5
//                } else {
//                    withAnimation {
//                        scale *= 1.5
//                    }
//                }
//            }
//    }
//}


//struct ContentView: View {
//    @State private var scale = 1.0
//
//    var body: some View {
//        Text("Hello, World!")
//            .scaleEffect(scale)
//            .onTapGesture {
//                withOptionalAnimation {
//                    scale *= 1.5
//                }
//            }
//    }
//    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
//        if UIAccessibility.isReduceMotionEnabled {
//            return try body()
//        } else {
//            return try withAnimation(animation, body)
//        }
//    }
//}

struct ContentView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}
//lecture-6-Supporting specific accessibility needs with SwiftUI

//lecture-5-How to be notified when your SwiftUI app moves to the background
//struct ContentView: View {
//    @Environment(\.scenePhase) var scenePhase
//
//    var body: some View {
//        Text("Hello, world!")
//            .padding()
//            .onChange(of: scenePhase) { newPhase in
//                if newPhase == .active {
//                    print("Active")
//                } else if newPhase == .inactive {
//                    print("Inactive")
//                } else if newPhase == .background {
//                    print("Background")
//                }
//            }
//    }
//}


//lecture-4-Triggering events repeatedly using a timer
//struct ContentView: View {
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    @State private var counter = 0
//
//    var body: some View {
//        Text("Hello, World!")
//            .onReceive(timer) { time in
//                if counter == 5 {
//                    timer.upstream.connect().cancel()
//                } else {
//                    print("The time is now \(time)")
//                }
//
//                counter += 1
//            }
//    }
//}

//lecture-3-Disabling user interactivity with allowsHitTesting()
//struct ContentView: View{
 //   var body: some View{
//        ZStack {
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Rectangle tapped!")
//                }
//
//            Circle()
//                .fill(.red)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Circle tapped!")
//                }
//        }
        /*If you try that out, you’ll find that tapping inside the circle prints “Circle tapped”, but on the rectangle behind the circle prints “Rectangle tapped” – even though the circle actually has the same frame as the rectangle.SwiftUI lets us control user interactivity in two useful ways*/
        //way -1
//        ZStack {
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Rectangle tapped!")
//                }
//
//            Circle()
//                .fill(.red)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Circle tapped!")
//                }
//                .allowsHitTesting(false) //Now tapping the circle will always print “Rectangle tapped!”, because the circle will refuses to respond to taps.
//        }
        //way-2
//        Circle()
//            .fill(.red)
//            .frame(width: 300, height: 300)
//            .contentShape(Rectangle())
//            .onTapGesture {
//                print("Circle tapped!")
//            }
        
        /*Where the contentShape() modifier really becomes useful is when you tap actions attached to stacks with spacers, because by default SwiftUI won’t trigger actions when a stack spacer is tapped.*/
//        VStack {
//            Text("Hello")
//            Spacer().frame(height: 100)
//            Text("World")
//        }
//        .onTapGesture {
//            print("VStack tapped!")
//        }
        /*f you run that you’ll find you can tap the “Hello” label and the “World” label, but not the space in between. However, if we use contentShape(Rectangle()) on the VStack then the whole area for the stack becomes tappable, including the spacer:*/
//        VStack {
//            Text("Hello")
//            Spacer().frame(height: 100)
//            Text("World")
//        }
//        .contentShape(Rectangle())
//        .onTapGesture {
//            print("VStack tapped!")
//        }
//
//    }
//}

//lecture-2-vibration and haptic
//struct ContentView: View{
//    var body: some View{
//        Text("Hello, World!")
//            .onTapGesture(perform: simpleSuccess)
//    }
//    func simpleSuccess() {
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.success)
//        //Try replacing .success with .error or .warning and see if you can tell the difference – .success and .warning are similar but different, I think.
//    }
//}
    /*
     For more advanced haptics, Apple provides us with a whole framework called Core Haptics
     */
//import CoreHaptics
//struct ContentView: View{
//    @State private var engine: CHHapticEngine? //
//    var body: some View{
//        Text("Hello, World!")
//            .onAppear(perform: prepareHaptics)
//            .onTapGesture(perform: complexSuccess)
//
//    }
//    func prepareHaptics() {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//
//        do {
//            engine = try CHHapticEngine()
//            try engine?.start()
//        } catch {
//            print("There was an error creating the engine: \(error.localizedDescription)")
//        }
//    }
//    func complexSuccess() {
//        // make sure that the device supports haptics
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//        var events = [CHHapticEvent]()
//
////        // create one intense, sharp tap
////        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
////        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
////        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
////        events.append(event)
//        for i in stride(from: 0, to: 1, by: 0.1) {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
//            events.append(event)
//        }
//
//        for i in stride(from: 0, to: 1, by: 0.1) {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
//            events.append(event)
//        }
//
//        // convert those events into a pattern and play it immediately
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try engine?.makePlayer(with: pattern)
//            try player?.start(atTime: 0)
//        } catch {
//            print("Failed to play pattern: \(error.localizedDescription).")
//        }
//    }
//
//}

//lecture-1-all about gestures
////struct ContentView: View {
////    var body: some View {
////        Text("Hello, World!")
////            .onTapGesture(count: 2) {
////                print("Double tapped!")
////            }
//
////            .onLongPressGesture {
////                    print("Long pressed!")
////                }
//
////            .onLongPressGesture(minimumDuration: 2) {
////                    print("Long pressed!")
////                }
//
////            .onLongPressGesture(minimumDuration: 1) {
////                   print("Long pressed!")
////               } onPressingChanged: { inProgress in
////                   print("In progress: \(inProgress)!")
////               }
////    }
//    /*For more advanced gestures you should use the gesture() modifier with one of the gesture structs: DragGesture, LongPressGesture, MagnificationGesture, RotationGesture, and TapGesture. These all have special modifiers, usually onEnded() and often onChanged() too, and you can use them to take action when the gestures are in-flight (for onChanged()) or completed (for onEnded()).*/
//
////}
//
////struct ContentView: View {
////    @State private var currentAmount = 0.0
////    @State private var finalAmount = 1.0
////
////    var body: some View {
////        Text("Hello, World!")
////            .scaleEffect(finalAmount + currentAmount)
////            .gesture(
////                MagnificationGesture()
////                    .onChanged { amount in
////                        currentAmount = amount - 1
////                    }
////                    .onEnded { amount in
////                        finalAmount += currentAmount
////                        currentAmount = 0
////                    }
////            )
////    }
////}
//
///*Exactly the same approach can be taken for rotating views using RotationGesture, except now we’re using the rotationEffect() modifier:*/
//
////struct ContentView: View {
////    @State private var currentAmount = Angle.zero
////    @State private var finalAmount = Angle.zero
////
////    var body: some View {
////        Text("Hello, World!")
////            .rotationEffect(currentAmount + finalAmount)
////            .gesture(
////                RotationGesture()
////                    .onChanged { angle in
////                        currentAmount = angle
////                    }
////                    .onEnded { angle in
////                        finalAmount += currentAmount
////                        currentAmount = .zero
////                    }
////            )
////    }
////}
//
///*Where things start to get more interesting is when gestures clash – when you have two or more gestures that might be recognized at the same time, such as if you have one gesture attached to a view and the same gesture attached to its parent.*/
//
////struct ContentView: View {
////    var body: some View {
////        VStack {
////            Text("Hello, World!")
////                .onTapGesture {
////                    print("Text tapped")
////                }
////        }
////        .onTapGesture {
////            print("VStack tapped")
////        }
////    }
////}
///*In this situation SwiftUI will always give the child’s gesture priority, which means when you tap the text view above you’ll see “Text tapped”. However, if you want to change that you can use the highPriorityGesture() modifier to force the parent’s gesture to trigger instead, like this:*/
//
////struct ContentView: View {
////    var body: some View {
////        VStack {
////            Text("Hello, World!")
////                .onTapGesture {
////                    print("Text tapped")
////                }
////        }
////        .highPriorityGesture(
////            TapGesture()
////                .onEnded { _ in
////                    print("VStack tapped")
////                }
////        )
////    }
////}
//
///*Alternatively, you can use the simultaneousGesture() modifier to tell SwiftUI you want both the parent and child gestures to trigger at the same time, like this:*/
//
////struct ContentView: View {
////    var body: some View {
////        VStack {
////            Text("Hello, World!")
////                .onTapGesture {
////                    print("Text tapped")
////                }
////        }
////        .simultaneousGesture(
////            TapGesture()
////                .onEnded { _ in
////                    print("VStack tapped")
////                }
////        )
////    }
////}
//
//struct ContentView: View {
//    // how far the circle has been dragged
//    @State private var offset = CGSize.zero
//
//    // whether it is currently being dragged or not
//    @State private var isDragging = false
//
//    var body: some View {
//        // a drag gesture that updates offset and isDragging as it moves around
//        let dragGesture = DragGesture()
//            .onChanged { value in offset = value.translation }
//            .onEnded { _ in
//                withAnimation {
//                    offset = .zero
//                    isDragging = false
//                }
//            }
//
//        // a long press gesture that enables isDragging
//        let pressGesture = LongPressGesture()
//            .onEnded { value in
//                withAnimation {
//                    isDragging = true
//                }
//            }
//
//        // a combined gesture that forces the user to long press then drag
//        let combined = pressGesture.sequenced(before: dragGesture)
//
//        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
//        Circle()
//            .fill(.red)
//            .frame(width: 64, height: 64)
//            .scaleEffect(isDragging ? 1.5 : 1)
//            .offset(offset)
//            .gesture(combined)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
