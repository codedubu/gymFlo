//
//  RoutineView.swift
//  gymFlo
//
//  Created by River McCaine on 8/4/22.
//

import SwiftUI

struct RoutineView: View {
    
    var routine: Routine
    
    var body: some View {
        VStack {
            Text(routine.name)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)
            List {
                
                ForEach(routine.workouts) { workout in
                    // WorkoutCell
                    HStack {
                        Text(workout.name)
                        Text("\(workout.sets) x")
                        Text("\(workout.reps)")
                        Text("Weight: \(workout.weight!) lbs")
                    }
                }
            }
        }
    }
}

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineView(routine: MockData.programs[0].routines.first!)
    }
}
