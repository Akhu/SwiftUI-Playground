//
//  Timer.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 20/06/2021.
//

import Foundation
import Combine

class TimerData : ObservableObject {
    
    @Published var timeCount = 0
    
    var timer : Timer?
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDidFire), userInfo: nil, repeats: true)
    }
    
    @objc func timerDidFire() {
        timeCount += 1
    }
    
    func resetCount() {
        timeCount = 0
    }
}

