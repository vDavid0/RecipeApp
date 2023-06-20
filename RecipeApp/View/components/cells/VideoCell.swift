//
//  VideoCell.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 22..
//

import UIKit

// Displays a recipes video as an image, at a users profile view
class VideoCell: UICollectionViewCell {
    static let id = String(describing: VideoCell.self)
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        imageView.pin(to: contentView)
    }
    
    // Set the image of the cell from outside of the class
    func setImageView(with image: UIImage) {
        imageView.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
