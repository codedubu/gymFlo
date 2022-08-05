//
//  Program.swift
//  gymFlo
//
//  Created by River McCaine on 8/4/22.
//

import Foundation

final class Program: Codable {
    var name: String
    var routines: [Routine]
    
    init(name: String, routines: [Routine] = []) {
        self.name       = name
        self.routines   = routines
    }
}

extension Program: Equatable {
    static func == (lhs: Program, rhs: Program) -> Bool {
        lhs.name == rhs.name && lhs.routines == rhs.routines
    }
}
