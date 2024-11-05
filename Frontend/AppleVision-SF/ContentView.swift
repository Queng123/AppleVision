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

    @State var enlarge = false

    var body: some View {
        VStack {
            Map()

            VStack {
                Button {
                    enlarge.toggle()
                } label: {
                    Text(enlarge ? "Reduce RealityView Content" : "Enlarge RealityView Content")
                }
                .animation(.none, value: 0)
                .fontWeight(.semibold)
            }
            .padding()
            .glassBackgroundEffect()
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
