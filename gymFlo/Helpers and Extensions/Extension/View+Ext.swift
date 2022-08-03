//
//  View+Ext.swift
//  gymFlo
//
//  Created by River McCaine on 8/2/22.
//

import SwiftUI

extension View {
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
