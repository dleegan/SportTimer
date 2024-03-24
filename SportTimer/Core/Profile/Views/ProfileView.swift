//
//  ProfileView.swift
//  SportTimer
//
//  Created by dleegan on 23/03/2024.
//

import SwiftUI
import UserNotifications

struct ProfileView: View {
    @State private var deviceToken: String = ""
    
    var body: some View {
        VStack {
            Text("Device Token:")
            Text(deviceToken)
                .padding()
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("DeviceTokenReceived"))) { notification in
            if let token = notification.userInfo?["deviceToken"] as? String {
                self.deviceToken = token
            } else {
                print("eeririridzjdjz")
            }
        }
    }
}

#Preview {
    ProfileView()
}
