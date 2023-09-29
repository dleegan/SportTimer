//
//  TimerManager.swift
//  SportTimer
//
//  Created by dleegan on 28/09/2023.
//

import Foundation
import SwiftUI
import ActivityKit

struct Session: Identifiable {
    enum mode {
        case prepare
        case work
        case rest
    }
    
    let id: UUID = UUID()
    let name: mode
    let time: Int
    
//    init(name: mode, time: Int) {
//        self.name = name
//        self.time = time
//    }
    
    func getName() -> String {
        switch self.name {
            case .prepare:
                return "Prepare"
            case .work:
                return "Work"
            case .rest:
                return "Rest"
        }
    }
    
    func getColor() -> Color {
        switch self.name {
            case .prepare:
                return .green
            case .work:
                return .red
            case .rest:
                return .blue
        }
    }
}


class TimerManager: ObservableObject {
    enum stopWatchMode {
        case running
        case stopped
        case paused
    }
    
    @Published var mode: stopWatchMode
    @Published var secondsElapsed: Int
    var step: Session
    var stepId: Int
    var timer = Timer()
    
    let session: [Session] = [
        Session(name: .prepare, time: 30),
        Session(name: .work, time: 30),
        Session(name: .rest, time: 20),
    ]
    
    init() {
        self.mode = .stopped
        self.timer = Timer()
        self.stepId = 0
        self.step = self.session[self.stepId]
        self.secondsElapsed = self.step.time
    }
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if (self.secondsElapsed <= 1) {
                self.stepId += 1
                if (self.stepId <= self.session.count - 1) {
                    self.step = self.session[self.stepId]
                    self.secondsElapsed = self.step.time
                } else {
                    self.stop()
                }
            } else {
                self.secondsElapsed -= 1
            }
        }
    }
    
    func pause() {
        timer.invalidate()
        mode = .paused
    }
    
    func stop() {
        timer.invalidate()
        self.stepId = 0
        self.step = self.session[self.stepId]
        self.secondsElapsed = self.step.time
        mode = .stopped
    }
}
