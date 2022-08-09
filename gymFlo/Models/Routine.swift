//
//  Routine.swift
//  gymFlo
//
//  Created by River McCaine on 8/4/22.
//

import Foundation

final class Routine: Codable, Identifiable { // A Day, B Day, Upper, Lower,
    var name: String
    var workouts: [Workout]
    
    init(name: String, workouts: [Workout] = []) {
        self.name       = name
        self.workouts   = workouts
    }
}

extension Routine: Equatable {
    static func == (lhs: Routine, rhs: Routine) -> Bool {
        lhs.name        == rhs.name &&
        lhs.workouts    == rhs.workouts
    }
}
