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
            Event(title: "The Multiverse Christmas Party", location: "The Multiverse, Palo Alto, CA", description: "A short talk by John Alioto from Google and lots of partying.", ticketLink: "https://lu.ma/wzp3sgwt", date: "Wednesday, December 18, 5:30 PM - 8:00 PM", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.447630149999995, longitude: -122.16237274736238))),
            Event(title: "AI For Developers #21", location: "972 Mission St, San Francisco, California", description: "​Discover the power of AI technologies like ChatGPT and Codex to streamline your development process and create innovative solutions.", ticketLink: "https://lu.ma/ai-for-developers-21", date: "Wednesday, December 18, 6:00 PM - 9:00 PM", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.7816984, longitude: -122.40839198986143))),
            Event(title: "Windsurf Launch Happy Hour", location: "General Catalyst, San Francisco, California", description: "During the event, you'll have the chance to hear from our team as they share insights into the journey of creating the first agentic IDE.", ticketLink: "https://lu.ma/2tlbw6we", date: "Thursday, December 19, 5:00 PM - 7:00 PM", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.785470849999996, longitude: -122.39806189004162))),
            Event(title: "Ho Ho HODL 🎅 A Bullish Holiday Party with Constellation, Base, and Walrus", location: "San Francisco, CA", description: "Networking & Happy Hour: Connect with builders, operators, and investors. It’s the perfect opportunity to dive into the SF Web3 scene before the year ends.", ticketLink: "https://lu.ma/x81qaetf", date: "Thursday, December 19, 6:00 PM - 9:00 PM", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.7792588, longitude: -122.4193286))),
            Event(title: "SF Meetup with Health Tech Nerds", location: "Mad Oak Bar ‘N’ Yard, Oakland, California", description: "​A casual happy hour for folks working or interested in healthcare/health tech to hang out and get to know one another! Anyone is welcome to attend.", ticketLink: "https://lu.ma/yc84zo8m", date: "Thursday, December 19, 6:00 PM - 8:00 PM", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.7998622, longitude: -122.2646424))),
            Event(title: "December 3H: Swap Edition!", location: "Spark Social SF, San Francisco, California", description: "​Let's do one last meetup for 2024! Since it's the season of giving, if you have pieces of hardware or craft supplies that you'd like to give away or swap with people, feel free to bring them. Maybe you'll end up making someone's winter extra fun. And as usual, if you have any projects you'd like to share, we'd be so excited to see them and learn more!", ticketLink: "https://lu.ma/t8ohatc3", date: "Thursday, December 19, 6:30 PM - 8:30 PM", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.77071705, longitude: -122.39159054085184))),
            Event(title: "Founders Running Club :: SF", location: "Main Parade Lawn, San Francisco, California", description: "Founders Running Club (FRC) brings founders, investors, tech, creative people and startup enthusiasts together for weekly easy runs and networking.", ticketLink: "https://lu.ma/ubtb4lb2", date: "Saturday, December 21, 9:30 AM - 12:00 PM", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .red, coordinates: CLLocationCoordinate2D(latitude: 37.80183955, longitude: -122.45823774901294))),
            Event(title: "Cable Car Museum", location: "Cable Car Museum, San Francisco, CA", description: "From the first run in 1873 to the present. Learn about the inventor, technologies, builders, rapid expansion, near loss and the ongoing efforts to save and rebuild the cable cars of San Francisco.", ticketLink: "https://www.cablecarmuseum.org/", date: "Tuesday - Sunday", mapInfo: Event.MapInfo(imageMarker: "pin", colorMarker: .purple, coordinates: CLLocationCoordinate2D(latitude: 37.79476015, longitude: -122.41185284314184))),
        ]
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
