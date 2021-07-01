//
//  GradientOnImage.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 30/06/2021.
//

import SwiftUI

struct GradientOnImage: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                ZStack {
                    ZStack {
                            Image("image-1")
                                .resizable()
                                .centerCropped()
                                .ignoresSafeArea()
                        }
                    }
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0)
                ]), startPoint: .top, endPoint: .center)
                    .frame(height: 300, alignment: .top)
                    .ignoresSafeArea()
                
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0)
                ]), startPoint: .bottom, endPoint: .center)
                .ignoresSafeArea()
                .frame(height: geometry.size.height, alignment: .bottom)
                
                
                    
            }
        }
    }
}

struct GradientOnImage_Previews: PreviewProvider {
    static var previews: some View {
        GradientOnImage()
    }
}
