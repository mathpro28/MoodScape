import AVFoundation
import UIKit

class CameraManager: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    private var captureSession: AVCaptureSession?
    private var currentInput: AVCaptureDeviceInput?
    private var videoOutput: AVCaptureVideoDataOutput?
    
    private var frameCaptureCompletion: ((UIImage?) -> Void)?
    private var isUsingFrontCamera = false

    override init() {
        super.init()
    }

    func configureCamera() {
        captureSession = AVCaptureSession()
        captureSession?.beginConfiguration()

        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Unable to access the back camera!")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: camera)
            if let session = captureSession, session.canAddInput(input) {
                session.addInput(input)
                currentInput = input
            } else {
                print("Unable to add input to session")
                return
            }

            let videoOutput = AVCaptureVideoDataOutput()
            if let session = captureSession, session.canAddOutput(videoOutput) {
                session.addOutput(videoOutput)
                self.videoOutput = videoOutput
                videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            }

            captureSession?.commitConfiguration()
            captureSession?.startRunning()
        } catch {
            print("Error setting up camera input: \(error)")
        }
    }

    func addPreviewLayer(to view: UIView) {
        guard let session = captureSession else {
            print("Capture session is not initialized")
            return
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
    }

    func captureFrame(completion: @escaping (UIImage?) -> Void) {
        self.frameCaptureCompletion = completion
    }

    // Safely unwrap session and input before switching camera
    func switchCamera() {
        guard let session = captureSession, let currentInput = currentInput else {
            print("Session or input not initialized")
            return
        }

        session.beginConfiguration()
        
        // Remove the current input
        session.removeInput(currentInput)
        
        let newCameraPosition: AVCaptureDevice.Position = isUsingFrontCamera ? .back : .front
        isUsingFrontCamera.toggle()

        guard let newCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: newCameraPosition) else {
            print("Unable to access the \(isUsingFrontCamera ? "front" : "back") camera!")
            session.commitConfiguration()
            return
        }

        do {
            let newInput = try AVCaptureDeviceInput(device: newCamera)
            if session.canAddInput(newInput) {
                session.addInput(newInput)
                self.currentInput = newInput
            } else {
                print("Unable to add the new camera input")
            }
        } catch {
            print("Error switching cameras: \(error)")
        }

        session.commitConfiguration()
    }
}
