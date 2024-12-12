//
//  ExpandableMenu.swift
//  AppleVision-SF
//
//  Created by Noah tesson on 12/11/24.
//

import SwiftUI

struct ExpandableMenu: View {
    @Binding var isExpanded: Bool
    @Binding var searchText: String
    @Binding var events: [Event]
    var onEventSelected: (Event) -> Void

    var body: some View {
        VStack {
            if isExpanded {
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.top)
                List(filteredEvents) { event in
                    Button(action: {
                        onEventSelected(event)
                    }) {
                        VStack(alignment: .leading) {
                            Text(event.title)
                                .font(.headline)
                            Text("\(event.location) - \(event.date)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 5)
                    }
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
            return events.filter { $0.title.contains(searchText) }
        }
    }
}
