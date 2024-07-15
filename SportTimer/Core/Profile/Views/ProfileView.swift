//
//  ProfileView.swift
//  SportTimer
//
//  Created by dleegan on 23/03/2024.
//

import SwiftUI
import UserNotifications

struct ProfileView: View {
    
    var body: some View {
        ContentUnavailableView {
            Label("Profil", systemImage: "person.fill")
        } description: {
            Text("Votre profil sera disponible dans les prochaines màj.")
        }
    }
}

#Preview {
    ProfileView()
}
