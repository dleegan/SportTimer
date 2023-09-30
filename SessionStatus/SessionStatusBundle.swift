//
//  SessionStatusBundle.swift
//  SessionStatus
//
//  Created by dleegan on 30/09/2023.
//

import WidgetKit
import SwiftUI

@main
struct SessionStatusBundle: WidgetBundle {
    var body: some Widget {
        SessionStatus()
        SessionStatusLiveActivity()
    }
}
