//
//  DescriptionStepCell.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 04..
//

import UIKit

// Used in AddDescriptionVC to get description input from user.
class DescriptionStepCell: UITableViewCell {
    static let id = String(describing: DescriptionStepCell.self)
    
    var stepTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textAlignment = .justified
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    private func setView() {
        contentView.addSubview(stepTextView)
        stepTextView.pinWithMargin(to: contentView)
    }
    
    //    nem storyboardbol/nibből hozzuk letre, hanem kódból
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
