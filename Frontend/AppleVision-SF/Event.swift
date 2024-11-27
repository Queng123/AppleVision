//
//  Event.swift
//  AppleVision-SF
//
//  Created by Tom Backert on 26.11.24.
//
import Foundation
import MapKit

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let location: CLLocationCoordinate2D
    let description: String
    let imageMap: String
    let date: String
}
