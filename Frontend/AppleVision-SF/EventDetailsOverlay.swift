//
//  Event.swift
//  AppleVision-SF
//
//  Created by Tom Backert on 26.11.24.
//

import SwiftUI
import MapKit

struct EventDetailOverlay: View {
    let event: Event
    let onClose: () -> Void
    var selectedEvent: Event?

    @State private var lookaroundScene: MKLookAroundScene?
    

    init(event: Event, onClose: @escaping () -> Void) {
            self.event = event
            self.onClose = onClose
            //print("Event Details: \(event)")
        }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    onClose()
                }
            
            VStack {
                VStack {
                    VStack{
                        Text(event.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        
                        
                        Text("Location: \(event.location)")
                            .font(.headline)
                            .padding(.bottom, 2)
                        
                        Text("Date: \(event.date)")
                            .font(.subheadline)
                            .padding(.bottom, 10)
                        
                        Text(event.description)
                            .font(.body)
                            .padding()
                        Button(action: {
                            if let url = URL(string: event.ticketLink) {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                Text("Buy tickets here!")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                    }
                    .padding()
                    HStack{
                        // Street View
                        if let lookaroundScene {
                            LookAroundPreview(initialScene: lookaroundScene)
                                .frame( width: 400, height: 200)
                                .padding()
                        } else {
                            ContentUnavailableView("No preview available", systemImage: "eye.slash")
                        }
                        // MISSING: Immersive View
                    }
                }
                .frame(width: 1000, height: 800)
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(15)
                .shadow(radius: 10)
                Button(action: onClose) {
                    Text("Close")
                        .font(.headline)
                        .frame(width: 100, height: 25)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .task {
                await fetchLookaroundPreview()
            }
        }
    }
    func fetchLookaroundPreview() async {
        lookaroundScene = nil
        let lookaroundRequest = MKLookAroundSceneRequest(coordinate: event.mapInfo.coordinates)
        do {
            lookaroundScene = try await lookaroundRequest.scene
        } catch {
            print("Error fetching LookAround scene: \(error)")
        }
    }
}

