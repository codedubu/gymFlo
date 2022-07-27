//
//  TimerViewModel.swift
//  gymFlo
//
//  Created by River McCaine on 7/26/22.
//

import SwiftUI
import Combine

let defaultTimeRemaining: CGFloat = 180

class TimerViewModel: ObservableObject {
    
    @Published var timeRemaining: CGFloat = defaultTimeRemaining
    @Published var isActive = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, self.isActive else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.isActive = false
                    self.timeRemaining = defaultTimeRemaining
                }
            }
            .store(in: &cancellables)
    }
}
