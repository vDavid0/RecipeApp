//
//  DescriptionViewController.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 31..
//

import UIKit

class DescriptionVC: UIViewController {
    private let descriptionView = DescriptionView()
    
    var recipe: Recipe? {
        didSet {
            descriptionView.setNameLabel(to: recipe?.name)
        }
    }
    
    override func loadView() {
        view = descriptionView
        descriptionView.stepsTableView.dataSource = self
        
//      half screen presentation mode by default
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DescriptionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.textLabel?.text = recipe?.description[indexPath.section] ?? ""
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .justified
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recipe?.description.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Step \(section + 1)"
    }
}
