//
//  SportTimerApp.swift
//  SportTimer
//
//  Created by dleegan on 25/09/2023.
//

import SwiftUI
import SwiftData

@main
struct SportTimerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Workout.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TabNavigation()
        }
        .modelContainer(sharedModelContainer)
    }
}
