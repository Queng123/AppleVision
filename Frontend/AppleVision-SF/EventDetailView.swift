//
//  Event.swift
//  AppleVision-SF
//
//  Created by Tom Backert on 26.11.24.
//

import SwiftUI

struct EventDetailView: View {
    let event: Event

    var body: some View {
        VStack {
            Text(event.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text("Location: \(event.location)")
                .font(.headline)
                .padding(.bottom, 2)
            Text("Date: \(event.date)")
                .font(.subheadline)
                .padding(.bottom, 10)
            Text(event.description)
                .font(.body)
                .padding()

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}
