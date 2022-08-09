//
//  GYFTabBar.swift
//  gymFlo
//
//  Created by River McCaine on 7/26/22.
//

import SwiftUI

struct GYFTabBar: View {
    
    @State var selectedTab: Tabs = .timer
    
    var body: some View {
        
        NavigationView {
            TabView(selection: $selectedTab) {
                ProgramView()
                    .tabItem { Label("Program", systemImage: "timer") }
                    .tag(Tabs.timer)
                
                FocusView()
                    .tabItem { Label("Focus", systemImage: "eye.circle.fill") }
                    .tag(Tabs.focus)
                
                SpotifyRemoteView()
                    .tabItem { Label("Remote", systemImage: "appletvremote.gen1.fill") }
                    .tag(Tabs.remote)
                
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gear") }
                    .tag(Tabs.settings)
            }
//            .navigationTitle(selectedTab.title)
        }
    }
}

struct GYFTabBar_Previews: PreviewProvider {
    static var previews: some View {
        GYFTabBar()
    }
}

// MARK: - Helpers
enum Tabs: String {
    case timer
    case focus
    case remote
    case settings
    
    var title: String {
        
        switch self {
        case .timer:
            return "Timer ⏳"
        case .focus:
            return "Focus 👁‍🗨"
        case .remote:
            return "Remote 🔊"
        case .settings:
            return "Settings ⚙️"
        }
    }
}
