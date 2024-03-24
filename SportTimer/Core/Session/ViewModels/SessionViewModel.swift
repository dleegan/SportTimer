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
    @Published var counter: Int

    var step: StepModeModel?
    var stepId: Int = 0
    var timer = Timer()

    var session: [StepModeModel]?

    init() {
        self.mode = .stopped
        self.counter = 0
        self.stepId = 0
        self.timer = Timer()
    }

    
    func start() {
        guard (self.session != nil) else { return }
        mode = .running

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            if (counter <= 1) {
                stepId += 1
                if (stepId <= session!.count - 1) {
                    step = session![stepId]
                    counter = step!.time
                    SoundManager.instance.playSound(stepSound: .whistle)
                } else {
                    stop()
                }
            } else {
                if (counter <= 4) {
                    SoundManager.instance.playSound(stepSound: .ending)
                }
                counter -= 1
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
        self.step = self.session![self.stepId]
        self.counter = self.step!.time
        mode = .stopped
    }

    func generateData(workout: Workout) {
        var item: [StepModeModel] = [StepModeModel(name: .prepare, time: workout.prepare ?? 0)]
        
        for _ in 1...(workout.sets ?? 0) {
            for _ in 1...(workout.cycles ?? 0) {
                item.append(StepModeModel(name: .work, time: workout.work ?? 0))
                item.append(StepModeModel(name: .rest, time: workout.rest ?? 0))
            }
            item.removeLast()
            item.append(StepModeModel(name: .rest_between_step, time: workout.rest_between_step ?? 0))
        }
        item.removeLast()
        item.append(StepModeModel(name: .cool_down, time: workout.cool_down ?? 0))
        
        self.session = item
        self.mode = .stopped
        self.timer = Timer()
        self.stepId = 0
        self.step = self.session![self.stepId]
        self.counter = self.step!.time
    }

    func changeStep(step: Int) {
        self.stepId = step
        self.step = self.session![self.stepId]
        self.counter = self.step!.time
    }
}
