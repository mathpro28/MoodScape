//
//  CameraManager.swift
//  MoodScape
//
//  Created by Mateo Mercado on 23/9/24.
//

import AVFoundation
import UIKit

class CameraManager: NSObject, ObservableObject {
    
    // MARK: - Properties
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var videoOutput = AVCaptureVideoDataOutput()
    private let cameraQueue = DispatchQueue(label: "CameraQueue")
    
    // Delegate to pass frames to the view or processing unit
    var delegate: AVCaptureVideoDataOutputSampleBufferDelegate?

    // MARK: - Setup
    func configureCamera() {
        checkCameraPermissions { [weak self] granted in
            guard let self = self else { return }
            if granted {
                self.setupSession()
            } else {
                print("Camera permission denied")
            }
        }
    }
    
    private func setupSession() {
        captureSession = AVCaptureSession()
        captureSession?.beginConfiguration()
        
        // Set the input (camera)
        guard let camera = AVCaptureDevice.default(for: .video),
              let cameraInput = try? AVCaptureDeviceInput(device: camera),
              (captureSession?.canAddInput(cameraInput) ?? false) else {
            print("Error: Could not add camera input")
            return
        }
        captureSession?.addInput(cameraInput)
        
        // Set the output (video frames)
        if captureSession?.canAddOutput(videoOutput) ?? false {
            videoOutput.setSampleBufferDelegate(delegate, queue: cameraQueue)
            captureSession?.addOutput(videoOutput)
        } else {
            print("Error: Could not add video output")
            return
        }
        
        captureSession?.commitConfiguration()
        startSession()
    }

    // MARK: - Preview Layer Setup
    func addPreviewLayer(to view: UIView) {
        guard let captureSession = captureSession else { return }
        
        // Create and configure the preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.frame = view.bounds
        
        // Add the preview layer to the provided view
        view.layer.addSublayer(previewLayer!)
    }

    // MARK: - Permissions
    private func checkCameraPermissions(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .denied, .restricted:
            completion(false)
        @unknown default:
            completion(false)
        }
    }

    // MARK: - Session Controls
    func startSession() {
        cameraQueue.async {
            self.captureSession?.startRunning()
        }
    }

    func stopSession() {
        cameraQueue.async {
            self.captureSession?.stopRunning()
        }
    }
    
    // Call this when capturing an image frame
    func captureFrame(completion: @escaping (UIImage?) -> Void) {
        // Logic to capture a frame and return it as a UIImage (handled by delegate)
    }
}
