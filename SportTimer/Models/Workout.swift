//
//  Workout.swift
//  SportTimer
//
//  Created by dleegan on 11/10/2023.
//

import Foundation
import SwiftData

@Model
class Workout {
    var title: String
    var created_at: Date
    var prepare: Int? = 0
    var work: Int? = 0
    var rest: Int? = 0
    var cycles: Int? = 0
    var sets: Int? = 0
    var rest_between_step: Int? = 0
    var cool_down: Int? = 0
    
//    init(title: String, created_at: Date, prepare: Int, work: Int, rest: Int, cycles: Int, sets: Int, rest_between_step: Int, cool_down: Int) {
//        self.title = title
//        self.created_at = Date()
//        self.prepare = prepare
//        self.work = work
//        self.rest = rest
//        self.cycles = cycles
//        self.sets = sets
//        self.rest_between_step = rest_between_step
//        self.cool_down = cool_down
//    }
    
    init (title: String) {
        self.title = title
        self.created_at = Date()
    }
}
