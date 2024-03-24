//
//  SportTimerApp.swift
//  SportTimer
//
//  Created by dleegan on 25/09/2023.
//

import SwiftUI
import SwiftData
import BackgroundTasks
import UserNotifications

@main
struct SportTimerApp: App {
    @Environment(\.scenePhase) private var phase
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
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
        .onChange(of: phase) {
            switch phase {
                case .background:
                    let request = BGAppRefreshTaskRequest(identifier: "timerBackground")
                    do {
                        try BGTaskScheduler.shared.submit(request) // Mark 3
                        print("Background Task Scheduled!")
                    } catch(let error) {
                        print("Scheduling Error \(error.localizedDescription)")
                    }
                default: break
            }
        }
        .backgroundTask(.appRefresh("timerBackground"), action: { _ in
            await updateWeatherData()
        })
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02hhx", $0) }.joined()
        NotificationCenter.default.post(name: Notification.Name("DeviceTokenReceived"), object: nil, userInfo: ["deviceToken": deviceTokenString])
    }
}

func updateWeatherData() async {
    print("test")
}
