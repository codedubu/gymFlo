//
//  TimerView.swift
//  gymFlo
//
//  Created by River McCaine on 7/26/22.
//

import SwiftUI

struct TimerView: View {
    
    @StateObject private var viewModel = TimerViewModel()
    
    var progressIndicator: CGFloat { 1 - ((defaultTimeRemaining - viewModel.timeRemaining) / defaultTimeRemaining) }
    
    var body: some View {
        
        ZStack{
            Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)

            VStack{
                ZStack{
                    TimerCircle(starting: 0, ending: 1, color: Color.black.opacity(0.09))
                    
                    TimerCircle(starting: 0, ending: progressIndicator, color: .brandPrimary)
                        .rotationEffect(.init(degrees: -90))
                    
                    Text(Int(viewModel.timeRemaining).toString())
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                }
                
                HStack(spacing: 20){
                    Button {
                        viewModel.isActive.toggle()
                    } label: {
                        TimerButton(imageName: viewModel.isActive ? "pause.fill" : "play.fill", buttonText: viewModel.isActive ? "Pause" : "Play", backgroundColor: .brandPrimary, foregroundColor: .white)
                    }
                    
                    Button {
                        viewModel.isActive = false
                        viewModel.timeRemaining = defaultTimeRemaining
                    } label: {
                        TimerButton(imageName: "arrow.clockwise", buttonText: "Restart", backgroundColor: .white, foregroundColor: .brandPrimary)
                    }
                }
                .padding(.top, 55)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

struct TimerCircle: View {
    
    var starting: CGFloat
    var ending: CGFloat
    var color: Color

    var body: some View {
        
        Circle()
            .trim(from: starting, to: ending)
            .stroke(color, style: StrokeStyle(lineWidth: 35, lineCap: .round))
            .frame(width: 280, height: 280)
    }
}

struct TimerButton: View {
    
    var imageName: String
    var buttonText: String
    var backgroundColor: Color
    var foregroundColor: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: imageName)
                .foregroundColor(foregroundColor)
        
            Text(buttonText)
                .foregroundColor(foregroundColor)
        }
        .padding(.vertical)
        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
        .background(backgroundColor)
        .clipShape(Capsule())
        .shadow(radius: 6)
        
    }
}
