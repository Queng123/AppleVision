//
//  Event.swift
//  AppleVision-SF
//
//  Created by Tom Backert on 26.11.24.
//
import Foundation


struct Event: Identifiable {
    let id = UUID()
    let title: String
    let location: String
    let date: String
}
