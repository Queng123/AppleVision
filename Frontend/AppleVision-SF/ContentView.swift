//
//  ContentView.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoin on 11/4/24.
//

import SwiftUI
import RealityKit
import MapKit

struct ContentView: View {
    @State private var searchText = ""
    @State private var isMenuExpanded = false
    @State private var events: [Event] = []
    @State private var selectedEvent: Event? = nil

    var body: some View {
        ZStack {
            VStack {
                MapView(events: $events, selectedEvent: $selectedEvent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                ExpandableMenu(
                    isExpanded: $isMenuExpanded,
                    searchText: $searchText,
                    events: $events,
                    onEventSelected: { event in
                        selectedEvent = event
                    }
                )
            }

            // Overlay for event details
            if let selectedEvent = selectedEvent {
                EventDetailOverlay(event: selectedEvent) {
                    self.selectedEvent = nil // Close the overlay
                }
            }
        }
        .onAppear {
            fetchEvents()
            print(events)
        }
    }

    private func fetchEvents() {
        events = [
            Event(title: "Tech Meetup", location: "SF Tech Hub", coordinates: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), description: "A meetup for tech enthusiasts.", imageMap: "star.fill", date: "2024-11-01"),
            Event(title: "Art Expo", location: "Golden Gate Gallery", coordinates: CLLocationCoordinate2D(latitude: 37.8010, longitude: -122.4350), description: "Explore stunning art exhibits.", imageMap: "paintbrush.fill", date: "2024-11-01"),
            Event(title: "Music Festival", location: "Pier 39", coordinates: CLLocationCoordinate2D(latitude: 37.8080, longitude: -122.4100), description: "Enjoy live music by the bay.", imageMap: "music.note", date: "2024-11-01"),
            Event(title: "AI Talk", location: "GitHub HQ", coordinates: CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.3969), description: "Discussion on AI advancements.", imageMap: "brain.head.profile", date: "2024-12-01"),
            Event(title: "Podium Discussion", location: "Notion HQ", coordinates: CLLocationCoordinate2D(latitude: 37.7899, longitude: -122.3977), description: "Panel discussion on productivity.", imageMap: "text.bubble", date: "2024-12-02"),
            Event(title: "AI Agent Hackathon", location: "AWS AI Loft", coordinates: CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.3937), description: "Hackathon for AI enthusiasts.", imageMap: "bolt", date: "2024-12-03")
        ]
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
