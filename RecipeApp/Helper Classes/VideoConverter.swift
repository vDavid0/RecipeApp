//
//  VideoConverter.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 12..
//

import Foundation
import UIKit
import AVFoundation

final class VideoConverter {
    static let shared = VideoConverter()
    
    func convertVideoToImage(with url: URL?) -> UIImage {
        guard let url = url else {return UIImage()}
        
        let asset = AVURLAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 0.0, preferredTimescale: 60)
        var firstFrameImage: UIImage?
        do {
            let cgFirstFrameImage = try generator.copyCGImage(at: timestamp, actualTime: nil)
            firstFrameImage = UIImage(cgImage: cgFirstFrameImage)
        } catch {
            print("Error generating image: \(error.localizedDescription)")
        }
        
        return firstFrameImage ?? UIImage()
    }
}
