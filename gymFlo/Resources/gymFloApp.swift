//
//  gymFloApp.swift
//  gymFlo
//
//  Created by River McCaine on 7/26/22.
//

import SwiftUI

@main
struct gymFloApp: App {
    let spotify = SpotifyRemoteViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            GYFTabBar()
                .environmentObject(spotify)
                .onOpenURL { url in
                    spotify.handleOpenURL(url)
                }
        }
    }
}
