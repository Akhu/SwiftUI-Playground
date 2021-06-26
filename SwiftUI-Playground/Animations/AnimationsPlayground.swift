//
//  ContentView.swift
//  Animations
//
//  Created by Anthony Da cruz on 11/03/2021.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .bottomLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .bottomLeading)
        )
    }
}

/*
-----------------
3D rotation effect
*/
struct AnimationPlayground: View {
    @State private var animationAmount = 0.0
    @State private var enabled = false
    
    var body: some View {
        Button("Tap Me") {
            enabled.toggle()
            // do nothing
            //Or
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) { self.animationAmount += 360
            }
        }
        .padding(50)
        .background(enabled ? Color.blue : Color.red)
        .animation(.default)
        .foregroundColor(.white)
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0.0, y: 1.0, z: 0.0)
            )
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
    }
}

//
///*
//-----------------
//Controlled Animation
//*/
//struct ContentView: View {
//    @State private var animationAmount: CGFloat = 1
//
//    var body: some View {
//        print(animationAmount)
//        return VStack {
//        Stepper("Scale amount", value: $animationAmount.animation(
//            Animation.easeInOut(duration: 1).repeatCount(3, autoreverses: true)
//            ), in: 1...10)
//
//        Spacer()
//        Button("Tap me") {
//            self.animationAmount += 1
//        }
//        .padding(50)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .scaleEffect(self.animationAmount)
//        }
//    }
//}
//
///*
//-----------------
//Animation with explicit and implicit + Drag gesture for a card
//*/
//struct ContentView: View {
//    @State private var dragAmount = CGSize.zero
//    var body: some View {
//        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            .gesture(DragGesture()
//                        .onChanged {  self.dragAmount = $0.translation
//                        }.onEnded { _ in
//                            withAnimation(.spring()){
//                                self.dragAmount = .zero
//                            }
//
//                        })
//            .frame(width: 300, height: 200)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .offset(dragAmount)
//            .animation(.spring())
//    }
//}
//
///*
//-----------------
//Fancy text animation with delay and drag
//**/
//struct ContentView: View {
//    let letters = Array("Hello SwiftUI")
//    @State private var enabled = false
//    @State private var dragAmount = CGSize.zero
//
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count) { num in
//                Text(String(self.letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(self.enabled ? Color.blue : Color.red)
//                    .offset(self.dragAmount)
//                    .animation(Animation.default.delay(Double(num) / 20))
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { self.dragAmount = $0.translation }
//                .onEnded { _ in
//                    self.dragAmount = .zero
//                    self.enabled.toggle()
//                }
//        )
//    }
//}
//
///**
//---
//**/
//
//struct CornerRotateModifier: ViewModifier {
//    let amount: Double
//    let anchor: UnitPoint
//
//    func body(content: Content) -> some View {
//        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
//    }
//}
//
//extension AnyTransition {
//    static var pivot: AnyTransition {
//        .modifier(
//            active: CornerRotateModifier(amount: -90, anchor: .bottomLeading),
//            identity: CornerRotateModifier(amount: 0, anchor: .bottomLeading)
//        )
//    }
//}
//
//struct ContentView: View {
//    @State private var isShowing = false
//    var body: some View {
//        VStack {
//            Button("Tap Me") {
//                withAnimation(){
//                    isShowing.toggle()
//                }
//            }
//            if isShowing {
//
//                    Rectangle()
//                        .fill(Color.red)
//                        .frame(width: 200, height: 200)
//                        .transition(.asymmetric(insertion: .pivot, removal: .pivot))
//
//
//            }
//        }
//    }
//}
////
////struct ContentView: View {
////    @State private var isShowing = false
////    var body: some View {
////        VStack {
////            Button("Tap Me") {
////                withAnimation(){
////                    isShowing.toggle()
////                }
////            }
////            if isShowing {
////
////                    Rectangle()
////                        .fill(Color.red)
////                        .frame(width: 200, height: 200)
////                        .transition(.asymmetric(insertion: .pivot, removal: .pivot))
////
////
////            }
////        }
////    }
////}
////
////
struct AnimationPlayground_Previews: PreviewProvider {
    static var previews: some View {
        AnimationPlayground()
    }
}
