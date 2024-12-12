//
//  Event.swift
//  AppleVision-SF
//
//  Created by Noah tesson on 12/11/24.
//

import Foundation
import MapKit
import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let location: String
    let description: String
    let date: String
    let mapInfo: MapInfo

    struct MapInfo {
        let imageMarker: String
        let colorMarker: Color
        let coordinates: CLLocationCoordinate2D
    }
    
    init(title: String, location: String, description: String, date: String, mapInfo: MapInfo) {
        self.title = title
        self.location = location
        self.description = description
        self.date = date
        self.mapInfo = mapInfo
    }
}
