//
//  ContentView.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoib on 24/02/2025.
//

import SwiftUI

struct ImageRecommandation: View {
    @State private var showImageGrid = true
    @State private var timeElapsed: [Int: TimeInterval] = [:]
    @State private var timers: [Int: Timer] = [:]
    
    let nbrImages: Int = 8
    
    var body: some View {
        ZStack {
            if showImageGrid {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showImageGrid = false
                    }
                
                ScrollView {
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible()), count: 4),
                        spacing: 10
                    ) {
                        ForEach(0..<nbrImages, id: \.self) { index in
                            Button(action: {
                                print("Image \(index) tapped")
                            }) {
                                VStack {
                                    Color.clear
                                        .background(.regularMaterial)
                                        .aspectRatio(1, contentMode: .fit)
                                        .clipShape(.rect(cornerRadius: 10))
                                        .overlay(
                                            Text(String(format: "%.1f", timeElapsed[index] ?? 0))
                                                .foregroundColor(.white)
                                                .font(.caption)
                                        )
                                }
                                .contentShape(.hoverEffect, .rect(cornerRadius: 20))
                                .hoverEffect { effect, isActive, proxy in
                                    effect.scaleEffect(!isActive ? 1.0 : 1.1)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .frame(maxWidth: 360)
                .padding()
            }
            
        }
    }
        
    func startTimer(for index: Int) {
        timers[index]?.invalidate()
        
        let startTime = Date()
        timers[index] = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            timeElapsed[index] = Date().timeIntervalSince(startTime)
        }
    }
    
    func stopTimer(for index: Int) {
        timers[index]?.invalidate()
        timers[index] = nil
    }
}

#Preview(windowStyle: .volumetric) {
    ImageRecommandation()
}
