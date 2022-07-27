//
//  Int+Ext.swift
//  gymFlo
//
//  Created by River McCaine on 7/26/22.
//

import Foundation

extension Int {
    
    func toString() -> String {
        let minutes = self / 60 % 60
        let seconds = self % 60
        return "\(minutes < 10 ? "\(minutes)" : "\(minutes)"):\(seconds < 10 ? "0\(seconds)" : "\(seconds)")"
    }
}


// let hours = self / 60 / 60 % 24
//\(hours < 10 ? "0\(hours)" : "\(hours)"):
