//
//  SessionViewModel.swift
//  SportTimer
//
//  Created by dleegan on 29/09/2023.
//

import Foundation
import SwiftUI
import ActivityKit

enum stopWatchMode {
    case running
    case stopped
    case paused
}

class SessionViewModel: ObservableObject {
    @Published var mode: stopWatchMode
    @Published var secondsElapsed: Int

    var step: StepModeModel
    var stepId: Int
    var timer = Timer()

    let session: [StepModeModel] = [
        StepModeModel(name: .prepare, time: 30),
        StepModeModel(name: .work, time: 30),
        StepModeModel(name: .rest, time: 20),
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
