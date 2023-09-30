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

    var step: StepModeModel
    var stepId: Int
    var timer = Timer()
    
    private var activity: Activity<SessionStatusAttributes>?
    private let attributes: SessionStatusAttributes

    let session: [StepModeModel] = [
        StepModeModel(name: .prepare, time: 10),
        StepModeModel(name: .work, time: 30),
        StepModeModel(name: .rest, time: 20),
    ]
    
    init() {
        self.mode = .stopped
        self.timer = Timer()
        self.stepId = 0
        self.step = self.session[self.stepId]
        self.counter = self.step.time
        self.attributes = SessionStatusAttributes()
    }
    
    func start() {
        mode = .running
        let initialState = SessionStatusAttributes.ContentState(counter: self.counter, stepName: self.step.getName())
        let content = ActivityContent(state: initialState, staleDate: nil, relevanceScore: 1.0)
        
        activity = try? Activity<SessionStatusAttributes>.request(
            attributes: attributes,
            content: content,
            pushType: nil
        )

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if (self.counter <= 1) {
                self.stepId += 1
                if (self.stepId <= self.session.count - 1) {
                    self.step = self.session[self.stepId]
                    self.counter = self.step.time
                    SoundManager.instance.playSound(stepSound: .whistle)
                } else {
                    self.stop()
                }
            } else {
                if (self.counter <= 4) {
                    SoundManager.instance.playSound(stepSound: .ending)
                }
                self.counter -= 1
            }
            Task {
                await self.activity?.update(
                    ActivityContent<SessionStatusAttributes.ContentState>(
                        state: SessionStatusAttributes.ContentState(counter: self.counter, stepName: self.step.getName()),
                        staleDate: nil
                    )
                )
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
        self.counter = self.step.time
        mode = .stopped

        Task {
            await activity?.end(
                _: activity?.content,
                dismissalPolicy:  .immediate
            )
        }
    }
}
