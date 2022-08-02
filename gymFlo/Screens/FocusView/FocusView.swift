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
    
        VStack {
            Spacer()
            TextEditor(text: $workout)
                .padding()
        }
    }
}

struct FocusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusView()
    }
}
