//
//  EventDetailsOverlay.swift
//  AppleVision-SF
//
//  Created by Noah tesson on 12/11/24.
//

import SwiftUI
import MapKit
import AVKit
import RealityKit

import QuickLook

struct EventDetailOverlay: View {
    let event: Event
    let onClose: () -> Void
    var selectedEvent: Event?

    
    @State private var isVideoPlaying = false
    @State private var videoPlayer: AVPlayer?

    @State private var lookaroundScene: MKLookAroundScene?
    

    init(event: Event, onClose: @escaping () -> Void) {
            self.event = event
            self.onClose = onClose
            //print("Event Details: \(event)")
        }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    onClose()
                }
            
            VStack {
                VStack {
                    VStack{
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
                    }
                    .padding()
                    VStack{
                        // Street View
                        if let lookaroundScene {
                            LookAroundPreview(initialScene: lookaroundScene)
                                .frame( width: 400, height: 200)
                                .padding()
                        } else {
                            ContentUnavailableView("No preview available", systemImage: "eye.slash")
                        }
                        // MISSING: Immersive View
                        Button("Play spatial video") {
                            playSpatialVideo()
                        }

                    }
                    .onDisappear {
                       // Stop video when the view disappears
                       videoPlayer?.pause()
                   }
                }
                .frame(width: 1000, height: 800)
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(15)
                .shadow(radius: 10)
                Button(action: onClose) {
                    Text("Close")
                        .font(.headline)
                        .frame(width: 100, height: 25)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .task {
                await fetchLookaroundPreview()
            }
        }
    }
    
    private func playSpatialVideo() {
        guard let videoURL = Bundle.main.url(forResource: "spatialVideo", withExtension: "MOV") else {
            print("Video file not found.")
            return
        }

        // Initialize AVPlayer
        videoPlayer = AVPlayer(url: videoURL)
        
        // Create an AVPlayerViewController for playback
        let playerViewController = AVPlayerViewController()
        playerViewController.player = videoPlayer
        
        // Present in a VisionOS environment
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let hostingController = UIHostingController(rootView: PlayerView(player: videoPlayer!))
            windowScene.windows.first?.rootViewController?.present(hostingController, animated: true, completion: {
                videoPlayer?.play()
            })
        }
    }
    
    func fetchLookaroundPreview() async {
        lookaroundScene = nil
        let lookaroundRequest = MKLookAroundSceneRequest(coordinate: event.mapInfo.coordinates)
        do {
            lookaroundScene = try await lookaroundRequest.scene
        } catch {
            print("Error fetching LookAround scene: \(error)")
        }
    }
}

struct PlayerView: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}
