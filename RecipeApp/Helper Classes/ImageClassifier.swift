//
//  ImageClassifier.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 10..
//

import AVFoundation
import Vision

protocol IngredientRecognisedDelegate {
    func ingredientRecognised(ingredient: Ingredients?)
}

final class ImageClassifier: NSObject {
    static let shared = ImageClassifier()
    
    var captureSession = AVCaptureSession()
    var result: Ingredients? // the result of the image classification
    {
        didSet {
            delegate?.ingredientRecognised(ingredient: result)
        }
    }
    
    private var currentPixelBuffer: CVImageBuffer?
    var delegate: IngredientRecognisedDelegate?
    
    
//  Set camera frame capturing. Input for displaying the image, output for the image classification
    func setupCaptureSession() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }
    
    func scan() {
        guard currentPixelBuffer != nil else { return }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: currentPixelBuffer!, orientation: .right, options: [:])
        do {
            try imageRequestHandler.perform([createIngredientsRequest()])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func createIngredientsRequest() -> VNCoreMLRequest {
        guard let ingredientsModel = try? VNCoreMLModel(for: ingredientsModel().model) else {
            fatalError("Unable to reach datamodel")
        }
        
        let request = VNCoreMLRequest(model: ingredientsModel) {  [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                  let topResult = results.first else {
                fatalError("Failed to make predictions with the model.")
            }
            self?.setResult(from: topResult.identifier)
        }
        return request
    }
    
//  convert a string (sender: ingredient request) to an Ingredient enum
    private func setResult(from ingredientString: String) {
        for ingredient in Ingredients.allCases {
            if ingredient.rawValue == ingredientString {
                result = ingredient
            }
        }
    }
    
    func startCapturing() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    
    func stopCapturing() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.captureSession.stopRunning()
        }
    }
}

extension ImageClassifier: AVCaptureVideoDataOutputSampleBufferDelegate {
    // store actual pixelbuffer
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        currentPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
    }
}


