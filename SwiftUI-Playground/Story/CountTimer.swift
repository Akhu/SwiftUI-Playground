//
//  CountTimer.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 23/06/2021.
//

import Foundation
import Combine

class CountTimer: ObservableObject {
    @Published var progress: Double
    
    private var interval: TimeInterval
    var max:Int = 0
    private let publisher: Timer.TimerPublisher
    private var cancellable: Cancellable?
    
    private var cancellableIndex: Cancellable?
    
    var data: [StoryData]?
    
    init(interval: TimeInterval) {
        self.progress = 0
        self.interval = interval
        self.publisher = Timer.publish(every: 0.1, on: .main, in: .default)
    }
    
    func start() {
        self.cancellable = self.publisher.autoconnect()
            .sink(receiveValue: { _ in
                //Each tick
                var newProgress = self.progress + (0.1/self.interval)
                
                if Int(newProgress) >= self.max { newProgress = 0 }
                
                self.progress = newProgress
        })
    }
    
    func advancePage(by number: Int){
        let newProgress = Swift.max((Int(self.progress) + number) % self.max, 0)
        self.progress = Double(newProgress)
    }
}
