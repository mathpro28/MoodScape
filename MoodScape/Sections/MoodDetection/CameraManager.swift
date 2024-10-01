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
    
    // MARK: - Request Camera Authorization
    func checkCameraAuthorization(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true) // Camera access granted
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .denied, .restricted:
            completion(false) // Camera access denied or restricted
        @unknown default:
            completion(false)
        }
    }
    
    // MARK: - Camera Configuration
    func configureCamera() {
        checkCameraAuthorization { authorized in
            guard authorized else {
                print("Camera access denied!")
                return
            }
            
            DispatchQueue.main.async {
                self.setupCaptureSession()
            }
        }
    }
    
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession?.beginConfiguration()

        do {
            try configureInput(position: .back)
            try configureOutput()
            captureSession?.commitConfiguration()
            
            // Run startRunning() on a background thread
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.captureSession?.startRunning()
            }
        } catch {
            print("Camera setup failed: \(error)")
            captureSession?.commitConfiguration()
        }
    }


    private func configureInput(position: AVCaptureDevice.Position) throws {
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) else {
            throw CameraError.unableToAccessCamera(position)
        }
        
        let input = try AVCaptureDeviceInput(device: camera)
        
        guard let session = captureSession, session.canAddInput(input) else {
            throw CameraError.unableToAddInput
        }
        
        session.addInput(input)
        currentInput = input
    }

    private func configureOutput() throws {
        let videoOutput = AVCaptureVideoDataOutput()
        
        guard let session = captureSession, session.canAddOutput(videoOutput) else {
            throw CameraError.unableToAddOutput
        }
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        session.addOutput(videoOutput)
        self.videoOutput = videoOutput
    }
    
    // MARK: - Preview Layer
    func addPreviewLayer(to view: UIView) {
        guard let session = captureSession else {
            print("Capture session is not initialized")
            return
        }

        DispatchQueue.main.async {
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.frame = view.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
        }
    }

    
    // MARK: - Frame Capture
    func captureFrame(completion: @escaping (UIImage?) -> Void) {
        self.frameCaptureCompletion = completion
    }
    
    // MARK: - Camera Switching
    func switchCamera() {
        guard let session = captureSession, let currentInput = currentInput else {
            print("Session or input not initialized")
            return
        }
        
        session.beginConfiguration()
        session.removeInput(currentInput)
        
        let newPosition: AVCaptureDevice.Position = isUsingFrontCamera ? .back : .front
        isUsingFrontCamera.toggle()
        
        do {
            try configureInput(position: newPosition)
        } catch {
            print("Error switching cameras: \(error)")
            session.commitConfiguration()
            return
        }
        
        session.commitConfiguration()
    }
    
    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let frameCaptureCompletion = frameCaptureCompletion else { return }
        guard let image = sampleBufferToImage(sampleBuffer: sampleBuffer) else {
            frameCaptureCompletion(nil)
            return
        }
        
        frameCaptureCompletion(image)
    }
    
    // MARK: - Utilities
    private func sampleBufferToImage(sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }
        
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let context = CIContext(options: nil)
        
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        return nil
    }
}

// MARK: - Camera Error
enum CameraError: Error, LocalizedError {
    case unableToAccessCamera(AVCaptureDevice.Position)
    case unableToAddInput
    case unableToAddOutput
    
    var errorDescription: String? {
        switch self {
        case .unableToAccessCamera(let position):
            return "Unable to access the \(position == .front ? "front" : "back") camera."
        case .unableToAddInput:
            return "Unable to add input to the session."
        case .unableToAddOutput:
            return "Unable to add output to the session."
        }
    }
}
