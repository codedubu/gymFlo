//
//  Alert.swift
//  gymFlo
//
//  Created by River McCaine on 8/2/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButotn: Alert.Button
}

struct AlertContext {
    // MARK: - Authorization Alerts
    static let failedAuthorization = AlertItem(title: Text("Failed to Authorize"), message: Text("There was an issue with connecting to Spotify, please makes ure you are logged in to Spotify and try again."), dismissButotn: .default(Text("OK")))
    
    // MARK: - Session Alerts
    static let sessionRenewed = AlertItem(title: Text("Session Renewed"), message: Text("The session has been renewed. You can breathe easy now."), dismissButotn: .default(Text("OK")))
}
