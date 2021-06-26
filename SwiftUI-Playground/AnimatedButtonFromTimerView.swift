//
//  AnimatedButtonFromTimerView.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 20/06/2021.
//

import SwiftUI

struct AnimatedButtonFromTimerView: View {
    @StateObject var timer = TimerData()
    
    @Namespace var animation
    
    var body: some View {
        VStack {
            
        Text("$\(timer.timeCount)")
            
            if timer.timeCount % 5 == 0 && timer.timeCount != 0 {
                Image(systemName: "photo.fill")
                    .id("Icon")
                    .transition(.scale.animation(.easeIn(duration: 0.2)).combined(with: .opacity.animation(.easeInOut(duration: 0.05))))
                    .matchedGeometryEffect(id: "AlbumTitle", in: animation)
            }
            
            if timer.timeCount % 5 != 0 {
                Image(systemName: "photo")
                    .id("Icon")
                    .transition(.scale.animation(.easeIn(duration: 0.2)).combined(with: .opacity.animation(.easeInOut(duration: 0.05))))
                    .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                    
            }
        
        
            
        }
    }
}

struct AnimatedButtonFromTimerView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedButtonFromTimerView()
    }
}
