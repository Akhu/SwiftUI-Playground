//
//  ObservedObjectTestView.swift
//  SwiftUI-Playground
//
//  Created by Anthony Da cruz on 11/07/2021.
//

import SwiftUI
import Combine
import Foundation

class SimpleTimer: ObservableObject {
    @Published var timer : Double = 0
    
    private var interval: TimeInterval
    var max:Int = 0
    private let publisher1: Timer.TimerPublisher
    private var cancellable1: Cancellable?
    
    init(interval: TimeInterval, every: TimeInterval) {
        self.interval = interval
        self.publisher1 = Timer.publish(every: every, on: .main, in: .default)
    }
    
    func start() {
        self.cancellable1 = self.publisher1.autoconnect()
            .sink(receiveValue: { _ in
                self.timer += 1
        })
    }
    
    func stop() {
        
    }
}


struct IndependentTimer: View {
    
    @StateObject var timer = SimpleTimer(interval: 0.1, every: 0.1)
        
    var body: some View {
        Text("Timer 1 \(timer.timer)")
            .onAppear {
                timer.start()
            }
    }
    
}


struct ObservedObjectTestView: View {
    @StateObject var timer = SimpleTimer(interval: 2, every: 2)
    
    @State var refreshCount = 0
    
    var body: some View {
        VStack {
            //Text("timer 1 value : \(timers.timer1)")
            AsyncImage(url: URL(string: "https://picsum.photos/400/500")!)
            Text("timer 2 value : \(timer.timer)")
            Text("Refresh Count : \(refreshCount)")
            IndependentTimer()
            
            Button(action: {
                timer.start()
            }, label: {
                Text("Start")
            })
        }
//        .onChange(of: timers.timer1, perform: { value in
//            refreshCount += 1
//        })
        .onChange(of: timer.timer, perform: { value in
            refreshCount += 1
        })
    }
}

struct ObservedObjectTestView_Previews: PreviewProvider {
    static var previews: some View {
        ObservedObjectTestView()
    }
}
