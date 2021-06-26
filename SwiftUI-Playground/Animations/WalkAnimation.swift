//
//  WalkAnimation.swift
//  Animations
//
//  Created by Anthony Da cruz on 01/06/2021.
//

import SwiftUI

struct WalkAnimation: View {
    @State private var animationFlag = false
    
    var animation: Animation {
        Animation.linear(duration: 2)
        .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Image("city")
                .offset(x: 0, y: 0.0)
                .modifier(makeOrbitEffect(diameter: 150))
                .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                .rotationEffect(Angle.degrees(-300))
                .animation(animation)
                
        }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .onAppear {
            self.animationFlag.toggle()
        }
    }
    
    func makeOrbitEffect(diameter: CGFloat) -> some GeometryEffect {
        return OrbitEffect(percent: self.animationFlag ? 1.0 : 0.0, radius: diameter / 2.0)
    }
}

struct WalkAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WalkAnimation()
    }
}


struct OrbitEffect: GeometryEffect {
    let initalAngle = CGFloat.random(in: 0..<2 * .pi)
    
    var percent : CGFloat = 0
    let radius: CGFloat
    
    var animatableData: CGFloat {
        get { return percent }
        set { percent = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let angle = 2 * .pi * percent + initalAngle
        let point = CGPoint(x: cos(angle) * radius, y: sin(angle) * radius)
        
        return ProjectionTransform(CGAffineTransform(translationX: point.x, y: point.y))
    }
}
