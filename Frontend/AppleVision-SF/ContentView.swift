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
            MapView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            ExpandableMenu(isExpanded: $isMenuExpanded, searchText: $searchText, events: $events)
        }
        .onAppear {
            fetchEvents()
        }
    }

    private func fetchEvents() {
        // Simulating event fetching from a source like LUMA
        events = [
            Event(title: "Tech Meetup", location: "SF Tech Hub", date: "2024-11-30"),
            Event(title: "Art Expo", location: "Golden Gate Gallery", date: "2024-12-01"),
            Event(title: "Music Festival", location: "Pier 39", date: "2024-12-05"),
            Event(title: "AI Talk", location: "GitHub HQ", date: "2024-12-02"),
            Event(title: "Podium Discussion", location: "Notion HQ", date: "2024-12-03"),
            Event(title: "AI Agent Hackathon", location: "AWS AI Loft", date: "2024-12-04"),
            Event(title: "AI Agent Hackathon", location: "AWS AI Loft", date: "2024-12-04")
        ]
    }
}

struct MapView: View {
    var body: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )))
    }
}

struct ExpandableMenu: View {
    @Binding var isExpanded: Bool
    @Binding var searchText: String
    @Binding var events: [Event]

    var body: some View {
        VStack {
            if isExpanded {
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.top)
                
                List(filteredEvents) { event in
                    VStack(alignment: .leading) {
                        Text(event.title)
                            .font(.headline)
                        Text("\(event.location) - \(event.date)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 5)
                }
                .frame(maxHeight: 300)
            }

            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                Text(isExpanded ? "Collapse Menu" : "Expand Menu")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color.white.opacity(0.9))
        .cornerRadius(15)
        .shadow(radius: 5)
    }

    private var filteredEvents: [Event] {
        if searchText.isEmpty {
            return events
        } else {
            return events.filter { $0.title.contains(searchText) || $0.location.contains(searchText) }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
