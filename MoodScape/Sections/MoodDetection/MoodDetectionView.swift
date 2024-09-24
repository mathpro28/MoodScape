//
//  MoodDetectionView.swift
//  MoodScape
//
//  Created by Mateo Mercado on 23/9/24.
//

import SwiftUI
import AVFoundation
import PhotosUI

struct MoodDetectionView: View {
    @ObservedObject var cameraManager = CameraManager()
    @State private var mood: String = "Detecting..."
    @State private var isPhotoPickerPresented = false
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack {
            // Camera preview or selected image
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.75)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 4))
                    .padding()
            } else {
                CameraPreview(cameraManager: cameraManager)
                    .onAppear {
                        cameraManager.configureCamera()
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.75)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 4))
                    .padding()
            }

            Text("Mood: \(mood)")
                .font(.title)
                .bold()
                .padding()

            // Button for detecting mood using camera feed
            Button("Detect Mood") {
                detectMood()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            // Button for selecting an image from Photos
            Button("Choose Image from Photos") {
                isPhotoPickerPresented = true
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .sheet(isPresented: $isPhotoPickerPresented) {
                PhotoPicker(selectedImage: $selectedImage)
            }

            Spacer()
        }
        .padding()
    }

    private func detectMood() {
        if let selectedImage = selectedImage {
            // Analyze mood using the selected image
            mood = analyzeMood(image: selectedImage)
        } else {
            // Analyze mood using camera frame
            cameraManager.captureFrame { image in
                mood = analyzeMood(image: image)
            }
        }
    }

    // Dummy function for mood analysis
    func analyzeMood(image: UIImage?) -> String {
        // Placeholder for CoreML model analysis
        return "Happy" // For testing purposes
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
        // Update view if needed
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images // Only show images
        config.selectionLimit = 1 // Limit to one image

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // No updates needed
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else { return }

            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    self.parent.selectedImage = image as? UIImage
                }
            }
        }
    }
}
