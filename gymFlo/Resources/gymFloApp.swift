//
//  gymFloApp.swift
//  gymFlo
//
//  Created by River McCaine on 7/26/22.
//

import SwiftUI

@main
struct gymFloApp: App {
    @StateObject private var spotify = SpotifyRemoteViewModel()
    
    var body: some Scene {
        WindowGroup {
            GYFTabBar()
                .environmentObject(spotify)
                .environmentObject(ProgramController.shared)
                .onOpenURL { url in
                    spotify.handleOpenURL(url)
                }
                
        }
    }
}
