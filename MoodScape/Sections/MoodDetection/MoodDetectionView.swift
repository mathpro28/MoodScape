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
        ZStack {
            Background()
            VStack {
                Spacer()
                Text("Mood: \(mood)")
                    .font(.title3)
                    .bold()
                    .padding()
                
                // Camera preview or selected image
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.7)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 4))
                        .padding()
                } else {
                    CameraPreview(cameraManager: cameraManager)
                        .onAppear {
                            cameraManager.configureCamera()
                        }
                        .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height * 0.7)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 4))
                        .padding()
                }
                
                HStack(spacing: 30) {
                    // Button for selecting an image from Photos
                    Button(action: {
                        isPhotoPickerPresented = true
                    }) {
                        VStack {
                            Image(systemName: "photo.fill.on.rectangle.fill")
                                .font(.largeTitle) // Larger icon size for better visibility
                                .foregroundColor(.blue) // Color that contrasts well with the theme
                            Text("Gallery")
                                .foregroundColor(.blue)
                                .font(.footnote)
                        }
                    }
                    .sheet(isPresented: $isPhotoPickerPresented) {
                        PhotoPicker(selectedImage: $selectedImage)
                    }

                    // Button for detecting mood (like a capture button)
                    Button(action: {
                        detectMood()
                    }) {
                        VStack {
                            Image(systemName: "face.smiling.fill") // More mood-related icon
                                .font(.largeTitle) // Large button to stand out
                                .foregroundColor(.green)
                            Text("Detect")
                                .foregroundColor(.green)
                                .font(.footnote)
                        }
                    }

                    // Button to switch between cameras
                    Button(action: {
                        cameraManager.switchCamera()
                    }) {
                        VStack {
                            Image(systemName: "arrow.triangle.2.circlepath.camera.fill") // Camera switch icon
                                .font(.largeTitle) // Adjust size for symmetry with other buttons
                                .foregroundColor(.purple)
                            Text("Switch")
                                .foregroundColor(.purple)
                                .font(.footnote)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 5)

            }
            .padding()
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
}

@ViewBuilder
func Background() -> some View {
    LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .bottom, endPoint: .top)
        .ignoresSafeArea(.all)
}

// Dummy function for mood analysis
func analyzeMood(image: UIImage?) -> String {
    // Placeholder for CoreML model analysis
    return "Happy" // For testing purposes
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

struct MoodDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        MoodDetectionView()
    }
}
