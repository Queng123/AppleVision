//
//  MapView.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoin on 11/26/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var events: [Event]

    @State private var region = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    )
    
    var body: some View {
            Map(position: $region) {
                ForEach(events) { event in
                    Marker(event.title, coordinate: event.coordinates)
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        }
}