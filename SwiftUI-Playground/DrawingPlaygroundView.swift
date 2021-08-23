//
//  DrawingPlaygroundView.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 11/07/2021.
//

import SwiftUI

struct Arc: Shape, InsettableShape {
    var insetAmount : CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
}

struct DrawingPlaygroundView: View {
    var body: some View {
        Arc(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)
    }
}

struct DrawingPlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPlaygroundView()
    }
}
