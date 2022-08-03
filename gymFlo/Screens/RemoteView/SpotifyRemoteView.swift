//
//  RemoteView.swift
//  gymFlo
//
//  Created by River McCaine on 7/26/22.
//

import SwiftUI

struct SpotifyRemoteView: View {
    
    @EnvironmentObject private var viewModel: SpotifyRemoteViewModel
    @State var scrollTText = false
    
    var body: some View {
        
        if viewModel.isConnectedToSpotify {
            VStack {
                Image(uiImage: viewModel.albumImage)
                    .resizable()
                    .frame(width: 350, height: 350)
                
                Text(viewModel.trackName)
                    .font(.title2)
                
                HStack(spacing: 24) {
                    Button {
                        viewModel.didTapNext()
                    }label: {
                        Image(systemName: "backward.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                    }
                    .tint(.brandPrimary)

                    
                    Button {
                        viewModel.didTapPauseOrPlay()
                    } label: {
                        Image(systemName: viewModel.isPaused ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 64, height: 64)
                    }
                    .tint(.brandPrimary)
                    
                    Button {
                        viewModel.didTapNext()
                    }label: {
                        Image(systemName: "forward.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                    }
                    .tint(.brandPrimary)

                }
            }
        } else {
            VStack {
                Text("Connect to Spotify")
                    .bold()
                    .font(.title)
                Button("Connect") {
                    viewModel.didTapConnect()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brandPrimary)
            }
        }
    }
}

struct RemoteView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyRemoteView()
    }
}
