//
//  FocusView.swift
//  gymFlo
//
//  Created by River McCaine on 7/26/22.
//

import SwiftUI

struct FocusView: View {
    
    @AppStorage("FierceFiveWorkout") private var workout = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextEditor(text: $workout)
                    .padding()
            }
            .toolbar {
                Button {
                    dismissKeyboard()
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                        .tint(.brandPrimary)
                }
            }
        }
      
    }
}

struct FocusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusView()
    }
}
