//
//  BackgroundManager.swift
//  SportTimer
//
//  Created by dleegan on 24/10/2023.
//

import Foundation
import BackgroundTasks

func scheduleAppRefresh() {
    let request = BGAppRefreshTaskRequest(identifier: "sprotTimer.one")
    try? BGTaskScheduler.shared.submit(request)
}
