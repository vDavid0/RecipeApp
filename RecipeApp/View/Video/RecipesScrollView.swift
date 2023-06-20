//
//  RecipeStackView.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 06..
//

import UIKit

// Contains a scrollable stack of recipes (videos and annotations)
class RecipesScrollView: UIScrollView {
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentInsetAdjustmentBehavior = .never // first video fills safe area
        isPagingEnabled = true
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        setLayout()
    }
    
    private func setLayout() {
        stackView.pin(to: self)
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}
