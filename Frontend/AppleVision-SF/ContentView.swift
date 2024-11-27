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

    var body: some View {
        VStack {
            MapView(events: $events)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            ExpandableMenu(isExpanded: $isMenuExpanded, searchText: $searchText, events: $events)
        }
        .onAppear {
            fetchEvents()
        }
    }

    private func fetchEvents() {
        events = [
            Event(title: "Tech Meetup", location: "SF Tech Hub", coordinates: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), description: " AI and VR", imageMap: "star.fill", date: "2024-11-01"),
            Event(title: "Art Expo", location: "Golden Gate Gallery", coordinates: CLLocationCoordinate2D(latitude: 37.8010, longitude: -122.4350), description: " AI and VR", imageMap: "star.fill", date: "2024-11-01"),
            Event(title: "Music Festival", location: "Pier 39", coordinates: CLLocationCoordinate2D(latitude: 37.8080, longitude: -122.4100), description: " AI and VR", imageMap: "star.fill", date: "2024-11-01"),
            Event(title: "AI Talk", location: "GitHub HQ", coordinates: CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.3969), description: " AI and VR", imageMap: "star.fill", date: "2024-11-01"),
            Event(title: "Podium Discussion", location: "Notion HQ", coordinates: CLLocationCoordinate2D(latitude: 37.7899, longitude: -122.3977), description: " AI and VR", imageMap: "star.fill", date: "2024-11-01"),
            Event(title: "AI Agent Hackathon", location: "AWS AI Loft", coordinates: CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.3937), description: " AI and VR", imageMap: "star.fill", date: "2024-11-01"),
            Event(title: "AI Agent Hackathon", location: "AWS AI Loft", coordinates: CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.3937), description: " AI and VR", imageMap: "star.fill", date: "2024-11-01"),

        ]
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
