//
//  ProgramViewModel.swift
//  gymFlo
//
//  Created by River McCaine on 8/8/22.
//

import Foundation

final class ProgramViewModel: ObservableObject {
    
    var selectedProgram: Program? {
        didSet { isShowingRoutineView = true }
    }
    
    @Published var isShowingRoutineView = false
}
