//
//  SessionStatusBundle.swift
//  SessionStatus
//
//  Created by dleegan on 29/09/2023.
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
