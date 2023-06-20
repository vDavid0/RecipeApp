//
//  ScanView.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 06..
//

import UIKit
import AVFoundation

// Contains the camera's (real-time) view full screen, a scan button for image classification and a nextButton to show added ingredients.
class ScanView: UIView {
    var scanButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "barcode.viewfinder"), for: .normal)
        button.imageView?.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit // image should fill the button
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.backgroundColor = .quaternaryLabel
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer()
        layer.session = ImageClassifier.shared.captureSession
        layer.videoGravity = .resizeAspectFill
        return layer
    }()
    
    var nextButton: NextButton = {
       let button = NextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
//        cameraPreviewLayer.frame = self.bounds
        self.layer.addSublayer(cameraPreviewLayer)
        addSubview(scanButton)
        addSubview(nextButton)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scanButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            scanButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scanButton.heightAnchor.constraint(equalToConstant: 80),
            scanButton.widthAnchor.constraint(equalToConstant: 80),
            
            nextButton.bottomAnchor.constraint(equalTo: scanButton.bottomAnchor),
            nextButton.leadingAnchor.constraint(equalTo: scanButton.trailingAnchor, constant: 20)
        ])
    }
    
//  camera layer should fill this view
    override func layoutSubviews() {
        cameraPreviewLayer.frame = self.bounds
    }
}
