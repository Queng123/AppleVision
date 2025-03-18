//
//  MapViewWrapper.swift
//  AppleVision-SF
//
//  Created by Quentin Brejoin on 3/10/25.
//

import SwiftUI
import MapKit

struct MapViewWrapper: View {
    @State private var region = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    )

    var body: some View {
        Map(position: $region)
            .frame(width: 400, height: 400)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
    }
}
