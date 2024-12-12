//
//  ContentView.swift
//  AppleVision-SF
//
//  Created by Noah tesson on 12/11/24.
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

            if let selectedEvent = selectedEvent {
                EventDetailOverlay(event: selectedEvent) {
                    self.selectedEvent = nil
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
            Event(title: "Tech Meetup", location: "SF Tech Hub", description: "AI and VR", date: "2024-11-01", mapInfo: Event.MapInfo(imageMarker: "star", colorMarker: .yellow, coordinates: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))),
            Event(title: "Art Expo", location: "Golden Gate Gallery", description: "AI and VR", date: "2024-11-01", mapInfo: Event.MapInfo(imageMarker: "star.fill", colorMarker: .blue, coordinates: CLLocationCoordinate2D(latitude: 37.8010, longitude: -122.4350))),
            Event(title: "Music Festival", location: "Pier 39", description: "AI and VR", date: "2024-11-01", mapInfo: Event.MapInfo(imageMarker: "star.fill", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.8080, longitude: -122.4100))),
            Event(title: "AI Talk", location: "GitHub HQ", description: "AI and VR", date: "2024-11-01", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .green, coordinates: CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.3969))),
            Event(title: "Podium Discussion", location: "Notion HQ", description: "AI and VR", date: "2024-11-01", mapInfo: Event.MapInfo(imageMarker: "heart.fill", colorMarker: .purple, coordinates: CLLocationCoordinate2D(latitude: 37.7899, longitude: -122.3977))),
            Event(title: "AI Agent Hackathon", location: "AWS AI Loft", description: "AI and VR", date: "2024-11-01", mapInfo: Event.MapInfo(imageMarker: "star.fill", colorMarker: .orange, coordinates: CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.3937))),
            Event(title: "AI Agent Hackathon", location: "AWS AI Loft", description: "AI and VR", date: "2024-11-01", mapInfo: Event.MapInfo(imageMarker: "star.fill", colorMarker: .orange, coordinates: CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.3937))),
        ]
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
