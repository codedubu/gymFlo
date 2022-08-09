//
//  RoutineView.swift
//  gymFlo
//
//  Created by River McCaine on 8/4/22.
//

import SwiftUI

struct RoutineView: View {
        
    var routine: Routine
    @Binding var isShowingRoutineView: Bool
    
    var body: some View {
        Text(routine.name)
    }
}

//struct RoutineView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoutineView(routine: <#Routine#>, isShowingRoutineView: .constan)
//    }
//}
