//
//  NextButton.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 29..
//

import UIKit

// used at ScanView. It has a badge that shows the number of added ingredients.
class NextButton: UIButton {
    private let badgeLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 20, height: 20))
    private var hasBadge = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setImage(UIImage(systemName: "rectangle.and.pencil.and.ellipsis"), for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        tintColor = .white
        initBadge()
    }
    
    private func initBadge() {
        badgeLabel.clipsToBounds = true
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.textColor = UIColor.white
        badgeLabel.text = "10"
        badgeLabel.backgroundColor = .red
        badgeLabel.textAlignment = .center
        badgeLabel.font = UIFont.systemFont(ofSize: 12)
        badgeLabel.layer.zPosition = 1
    }
    
    private func addBadge(with number: Int) {
        badgeLabel.text = String(number)
        self.addSubview(badgeLabel)
        hasBadge = true
    }
    
    private func removebadge() {
        badgeLabel.removeFromSuperview()
        hasBadge = false
    }
    
    func setBadge(to number: Int) {
        if hasBadge {
            switch number {
            case 0:
                removebadge()
            default:
                badgeLabel.text = String(number)
            }
        } else {
            switch number {
            case 0:
                break
            default:
                addBadge(with: number)
            }
        }
        
        if number > 0 {
            hasBadge = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
