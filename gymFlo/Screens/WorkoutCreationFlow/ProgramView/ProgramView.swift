//
//  ProgramView.swift
//  gymFlo
//
//  Created by River McCaine on 8/4/22.
//

import SwiftUI

struct ProgramView: View {
    
    @StateObject var viewModel = ProgramViewModel()
    
    @EnvironmentObject var programController: ProgramController
    
    @State private var programName: String = ""
    
    var body: some View {
        VStack{
            Text("New Program")
                .font(.largeTitle)
                .fontWeight(.medium)
            
            TextField("Program Name", text: $programName)
            
            List {
                ForEach(programController.programs) { program in
                    NavigationLink(destination: RoutineView(routines: program.routines, isShowingRoutineView: $viewModel.isShowingRoutineView)) {
                        Text(program.name)
                    }
                }
                .onDelete(perform: programController.deleteProgram)
            }
            
            Button {
                programController.createProgramWith(newName: programName)
                programName = ""
            } label: {
                Text("Create")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
}

struct ProgramView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramView()
            .environmentObject(ProgramController.shared)
    }
}
