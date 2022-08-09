//
//  RoutineView.swift
//  gymFlo
//
//  Created by River McCaine on 8/4/22.
//

import SwiftUI

struct RoutineView: View {
    
    @EnvironmentObject var programController: ProgramController
    var routines: [Routine]
    @Binding var isShowingRoutineView: Bool
    
    
    @State private var routineName: String = ""
    
    var body: some View {
        VStack {
            TextField("Routine Name", text: $routineName)
            
            Button {
                RoutineController.createRoutineWith(name: routineName, program: programController.programs[0])
            } label: {
                Text("Add routine")
            }

            List {
                ForEach(routines) { routine in
                    Text(routine.name)
                }
            }
        }
    }
}

//struct RoutineView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoutineView(routines: MockData.programs[0].routines, isShowingRoutineView: .constant(false))
//    }
//}
