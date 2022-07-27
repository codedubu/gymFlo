//
//  SettingsView.swift
//  gymFlo
//
//  Created by River McCaine on 7/26/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Text("Rate the app! ✨")
                .bold()
            Text("Check out my GitHub 💻")
                .bold()
            Text("Find me on LinkedIn 🔗")
                .bold()
            Text("Hit me up on Twitter 🐦")
                .bold()
            Text("There's something I'm not seeing... 🤔")
                .bold()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
