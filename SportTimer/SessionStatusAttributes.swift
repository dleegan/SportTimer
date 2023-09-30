//
//  SessionStatusAttributes.swift
//  SportTimer
//
//  Created by dleegan on 30/09/2023.
//

import Foundation
import ActivityKit

struct SessionStatusAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
//        var emoji: String
        var counter: Int
        var stepName: String
    }
    
    // Fixed non-changing properties about your activity go here!
//    var name: String
}
