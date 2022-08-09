//
//  Program.swift
//  gymFlo
//
//  Created by River McCaine on 8/4/22.
//

import Foundation

final class Program: Codable, Identifiable { // Fierce 5
    var name: String
    var routines: [Routine]
    
    init(name: String, routines: [Routine] = []) {
        self.name       = name
        self.routines   = routines
    }
}

extension Program: Equatable {
    static func == (lhs: Program, rhs: Program) -> Bool {
        lhs.name        == rhs.name &&
        lhs.routines    == rhs.routines
    }
}


struct MockData {
    
    static let programs = [ Program(name: "Fierce 5",
                                    routines: [Routine(name: "A Day",
                                                       workouts: [Workout(name: "Squat", sets: 3, reps: 5, weight: 205),
                                                                  Workout(name: "Bench", sets: 3, reps: 5, weight: 145),
                                                                  Workout(name: "Pendlay", sets: 3, reps: 8, weight: 100),
                                                                  Workout(name: "Face Pull", sets: 3, reps: 10, weight: 80),
                                                                  Workout(name: "Tricep Press-Down", sets: 2, reps: 10, weight: 90),
                                                                  Workout(name: "Calf Raises", sets: 2, reps: 15, weight: 70),
                                                                 ]),
                                               Routine(name: "B Day",
                                                       workouts: [Workout(name: "Front Squat", sets: 3, reps: 5, weight: 185),
                                                                  Workout(name: "Overhead Press", sets: 3, reps: 5, weight: 95),
                                                                  Workout(name: "RDL", sets: 3, reps: 8, weight: 145),
                                                                  Workout(name: "Lat Pulldown", sets: 3, reps: 8, weight: 80),
                                                                  Workout(name: "Bicep Curls", sets: 2, reps: 10, weight: 30),
                                                                  Workout(name: "Ab Work", sets: 2, reps: 15, weight: 0),
                                                                 ]),
                                    ])]
}
