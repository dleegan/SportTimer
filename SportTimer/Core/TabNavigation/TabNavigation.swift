//
//  TabNavigation.swift
//  SportTimer
//
//  Created by dleegan on 30/09/2023.
//

import SwiftUI

protocol Title_Enum  {
    var title: String { get }
}

enum tabTitle: Int, Title_Enum {
    case home = 1
    case sessions = 2
    case historique = 3
    case profil = 4

    var title: String {
        switch self {
            case .home:
                return "Home"
            case .sessions:
                return "Sessions"
            case .historique:
                return "Historique"
            case .profil:
                return "Profil"
        }
    }
}

struct TabNavigation: View {
    @State var selection = 2

    var body: some View {
        TabView(
            selection: $selection,
            content:  {
                SessionView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }.tag(1)

                SessionsListView()
                    .tabItem {
                        Label("Sessions", systemImage: "stopwatch")
                    }.tag(2)

                Text("Historique")
                    .tabItem {
                        Label("Historique", systemImage: "calendar")
                    }.tag(3)

                Text("Tab Content 2")
                    .tabItem {
                        Label("Profil", systemImage: "person.circle.fill")
                    }.tag(4)
            })
            
    }
}

#Preview {
    TabNavigation()
}
