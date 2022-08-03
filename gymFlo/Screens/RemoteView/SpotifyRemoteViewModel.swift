//
//  SpotifyController.swift
//  gymFlo
//
//  Created by River McCaine on 8/1/22.
//

import Foundation
import Combine
import SwiftUI

final class SpotifyRemoteViewModel: NSObject, ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var isConnectedToSpotify = false
    @Published var isPaused = false
    @Published var trackName = ""
    @Published var albumImage = PlaceholderImage.album
    
    var responseCode: String? {
        didSet {
            fetchAccessToken { (dictionary, error) in
                if let error = error {
                    print("Fetching token request error \(error)")
                    return
                }
                let accessToken = dictionary!["access_token"] as! String
                DispatchQueue.main.async {
                    self.appRemote.connectionParameters.accessToken = accessToken
                    self.appRemote.connect()
                }
            }
        }
    }
    
    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        return appRemote
    }()
    
    var accessToken = UserDefaults.standard.string(forKey: accessTokenKey) {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(accessToken, forKey: accessTokenKey)
        }
    }
    
    lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: spotifyClientId, redirectURL: redirectUri)
        configuration.playURI = ""
        configuration.tokenSwapURL = URL(string: "http://localhost:1234/swap")
        configuration.tokenRefreshURL = URL(string: "http://localhost:1234/refresh")
        return configuration
    }()
    
    lazy var sessionManager: SPTSessionManager? = {
        let manager = SPTSessionManager(configuration: configuration, delegate: self)
        return manager
    }()
    
    private var lastPlayerState: SPTAppRemotePlayerState?
    
    private var connectCancellable: AnyCancellable?
    
    private var disconnectCancellable: AnyCancellable?
    
    
    override init() {
        super.init()
        connectCancellable = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.connect()
            }
        
        disconnectCancellable = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.disconnect()
            }
    }
    
    func connect() {
        guard let _ = self.appRemote.connectionParameters.accessToken else {
            self.appRemote.authorizeAndPlayURI("")
            return
        }
        
        appRemote.connect()
    }
    
    
    func disconnect() {
        if appRemote.isConnected {
            appRemote.disconnect()
        }
    }
    
    // MARK: - Networking
    func handleOpenURL(_ url: URL) {
        let parameters = self.appRemote.authorizationParameters(from: url)
        
        if let code = parameters?["code"] {
            self.responseCode = code
        } else if let access_token = parameters?[SPTAppRemoteAccessTokenKey] {
            self.accessToken = access_token
        } else if let error_description = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print("No access token error =", error_description)
        }
    }
    
    
    func fetchAccessToken(completion: @escaping ([String: Any]?, Error?) -> Void) {
        let url = URL(string: "https://accounts.spotify.com/api/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let spotifyAuthKey = "Basic \((spotifyClientId + ":" + spotifyClientSecretKey).data(using: .utf8)!.base64EncodedString())"
        request.allHTTPHeaderFields = ["Authorization": spotifyAuthKey,
                                       "Content-Type": "application/x-www-form-urlencoded"]
        
        var requestBodyComponents = URLComponents()
        let scopeAsString = stringScopes.joined(separator: " ")
        
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "client_id", value: spotifyClientId),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: responseCode!),
            URLQueryItem(name: "redirect_uri", value: redirectUri.absoluteString),
            URLQueryItem(name: "code_verifier", value: ""), // not currently used
            URLQueryItem(name: "scope", value: scopeAsString),
        ]
        
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,                              // is there data
                  let response = response as? HTTPURLResponse,  // is there HTTP response
                  (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                  error == nil else {                           // was there no error, otherwise ...
                print("Error fetching token \(error?.localizedDescription ?? "")")
                return completion(nil, error)
            }
            let responseObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            print("Access Token Dictionary=", responseObject ?? "")
            completion(responseObject, nil)
        }
        task.resume()
    }
    
    
    func fetchArtwork(for track: SPTAppRemoteTrack) {
        appRemote.imageAPI?.fetchImage(forItem: track, with: CGSize.zero, callback: { [weak self] (image, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching track image: " + error.localizedDescription)
            } else if let image = image as? UIImage {
                self.albumImage = image
            }
        })
    }
    
    
    func fetchPlayerState() {
        appRemote.playerAPI?.getPlayerState({ [weak self] (playerState, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getting player state:" + error.localizedDescription)
            } else if let playerState = playerState as? SPTAppRemotePlayerState {
                self.update(playerState: playerState)
            }
        })
    }
    
    
    // MARK: - UI Changes
    func update(playerState: SPTAppRemotePlayerState) {
        if lastPlayerState?.track.uri != playerState.track.uri { fetchArtwork(for: playerState.track) }
        lastPlayerState = playerState
        trackName = playerState.track.name
        
        if playerState.isPaused {
            isPaused = false
        } else {
            isPaused = true
        }
        
    }
    
    
    func updateConnectionStatus() {
        if appRemote.isConnected == true {
            isConnectedToSpotify = true
        }
        else {
            isConnectedToSpotify = false
        }
    }
    
    // MARK: - didTaps
    func didTapPauseOrPlay() {
        if let lastPlayerState = lastPlayerState, lastPlayerState.isPaused {
            appRemote.playerAPI?.resume(nil)
        } else {
            appRemote.playerAPI?.pause(nil)
        }
        
    }
    
    
    func didTapSignOut() {
        if appRemote.isConnected == true {
            appRemote.disconnect()
        }
    }
    
    
    func didTapConnect() {
        guard let sessionManager = sessionManager else { return }
        sessionManager.initiateSession(with: scopes, options: .clientOnly)
    }
    
    
    func didTapNext() {
        appRemote.playerAPI?.skip(toNext: { thang, error in
            if let error = error {
                print("Error getting next song to update with player state:" + error.localizedDescription)
            }
        })
    }
    
    func didTapPrevious() {
        appRemote.playerAPI?.skip(toPrevious: { thang, error in
            if let error = error {
                print("Error getting previous song to update with player state:" + error.localizedDescription)
            }
        })

    }
} // END OF CLASS


// MARK: - Delegate Extensions
extension SpotifyRemoteViewModel: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        updateConnectionStatus()
        appRemote.playerAPI?.delegate = self
        appRemote.playerAPI?.subscribe(toPlayerState: { (success, error) in
            if let error = error {
                print("Error subscribing to player state:" + error.localizedDescription)
            }
        })
        fetchPlayerState()
    }
    
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        updateConnectionStatus()
        lastPlayerState = nil
    }
    
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        updateConnectionStatus()
        lastPlayerState = nil
    }
}


extension SpotifyRemoteViewModel: SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        debugPrint("Spotify Track name: %@", playerState.track.name)
        update(playerState: playerState)
    }
}


extension SpotifyRemoteViewModel: SPTSessionManagerDelegate {
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        if error.localizedDescription == "The operation couldn’t be completed. (com.spotify.sdk.login error 1.)" {
            print("AUTHENTICATE with WEBAPI")
        } else {
            if let gyfError = error as? GYFError {
                switch gyfError {
                case .failedAuthorization:
                    alertItem = AlertContext.failedAuthorization
                }
            }
        }
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        alertItem = AlertContext.sessionRenewed
    }
    
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        appRemote.connectionParameters.accessToken = session.accessToken
        appRemote.connect()
        
    }
}
