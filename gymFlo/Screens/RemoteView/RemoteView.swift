//
//  RemoteView.swift
//  gymFlo
//
//  Created by River McCaine on 7/26/22.
//

import SwiftUI

struct RemoteView: View {
    
    var body: some View {
        
        VStack {
            
            Spacer()
                        
            Image("thewutang")
                .frame(width: 350, height: 350, alignment: .center)
            
            Text("C.R.E.A.M (Cash Rules Everything Around Me)")
                .font(.title3)
            
            HStack(spacing: 44) {
                SystemIconView(name: "backward.fill")
                SystemIconView(name: "play.fill")
                SystemIconView(name: "forward.fill")
            }
            
            Spacer()
        }
    }
}

struct RemoteView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteView()
    }
}

struct SystemIconView: View {
    
    var name: String
    
    var body: some View {
        Image(systemName: name)
            .resizable()
            .scaledToFit()
            .frame(width: 52, height: 52)
    }
}

