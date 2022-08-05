//
//  RoutineController.swift
//  gymFlo
//
//  Created by River McCaine on 8/4/22.
//

import Foundation

final class RoutineController {
    
    // MARK: -  CRUD Methods
    // Routines
    static func createRoutineWith(name: String, program: Program) {
        let newRoutine = Routine(name: name)
        ProgramController.shared.addRoutineTo(program: program, routine: newRoutine)
    }
    
    
    // Workouts
    static func addWorkoutTo(routine: Routine, workout: Workout) {
        routine.workouts.append(workout)
        ProgramController.shared.saveToPersistenceStore()
    }
    
    // update
    // delete
}
