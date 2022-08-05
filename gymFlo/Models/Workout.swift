//
//  Workout.swift
//  gymFlo
//
//  Created by River McCaine on 8/4/22.
//

import Foundation

final class Workout: Codable {
    var name: String
    var sets: Int
    var reps: Int
    var weight: Int
    
    init(name: String, sets: Int, reps: Int, weight: Int) {
        self.name   = name
        self.sets   = sets
        self.reps   = reps
        self.weight = weight
    }
}

extension Workout: Equatable {
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        lhs.name    == rhs.name &&
        lhs.sets    == rhs.sets &&
        lhs.reps    == rhs.reps &&
        lhs.weight  == rhs.weight
    }
}
