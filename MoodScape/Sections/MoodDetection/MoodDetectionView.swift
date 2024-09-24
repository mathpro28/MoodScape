//
//  MoodDetectionView.swift
//  MoodScape
//
//  Created by Mateo Mercado on 23/9/24.
//

import SwiftUI
import AVFoundation

struct MoodDetectionView: View {
    @ObservedObject var cameraManager = CameraManager()
    @State private var mood: String = "Detecting..."

    // Preview for the camera feed
    var body: some View {
        VStack {
            CameraPreview(cameraManager: cameraManager)
                .onAppear {
                    cameraManager.configureCamera()
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.75)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 4))
                .padding()

            Text("Mood: \(mood)")
                .font(.title)
                .bold()
                .padding()

            Button("Detect Mood") {
                // Implement mood detection logic
                detectMood()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    private func detectMood() {
        // This function would interact with the CameraManager to capture a frame
        // and use your CoreML model to analyze the mood
        cameraManager.captureFrame { image in
            // Assume `analyzeMood(image: UIImage)` is your function to analyze the mood
            mood = analyzeMood(image: image)
        }
    }
    
    // Dummy function to replace with actual mood analysis
    func analyzeMood(image: UIImage?) -> String {
        // Placeholder for mood analysis logic
        return "Happy" // Return detected mood
    }
}

struct CameraPreview: UIViewRepresentable {
    var cameraManager: CameraManager

    func makeUIView(context: Context) -> some UIView {
        let previewView = UIView(frame: UIScreen.main.bounds)
        previewView.clipsToBounds = true
        cameraManager.addPreviewLayer(to: previewView)
        return previewView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Update the view if needed
    }
}
