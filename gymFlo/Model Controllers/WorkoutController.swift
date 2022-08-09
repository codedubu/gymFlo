//
//  WorkoutController.swift
//  gymFlo
//
//  Created by River McCaine on 8/4/22.
//

import Foundation

final class WorkoutController {
    
    // MARK: - Workouts
    static func createWorkout(name: String, sets: Int, reps: Int, weight: Int, routine: Routine) {
        let newWorkout = Workout(name: name, sets: sets, reps: reps, weight: weight)
        RoutineController.addWorkoutTo(routine: routine, workout: newWorkout)
    }
    
    // update
    // delete
}
