//
//  MenuVC.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 07..
//

import UniformTypeIdentifiers
import UIKit

class MenuVC: UITableViewController {
    private let menuItems = ["Upload new recipe", "Log Out"]
    private let menuImages = [UIImage(systemName: "plus")!, UIImage(systemName: "arrow.left.to.line")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
    }
    
    private func addRecipe(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = [UTType.movie.identifier]
        present(picker, animated: true)
    }
    
    private func logOut() {
        //        TODO: log out
    }
}

extension MenuVC {
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: .none)
        cell.textLabel?.text =  menuItems[indexPath.row]
        cell.imageView?.image = menuImages[indexPath.row]
        cell.imageView?.tintColor = .label

        cell.accessoryType = .disclosureIndicator // Add the arrow to the right of the cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Account Settings"
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            addRecipe()
        case 1:
            logOut()
        default:
            break
        }
    }
}

extension MenuVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let videoUrl = info[.mediaURL] as? URL else { return }
        
        let addRecipeVC = AddRecipeVC()
        addRecipeVC.setVideo(with: videoUrl)
        
        let navController = UINavigationController(rootViewController: addRecipeVC)
        present(navController, animated: true)
    }
}
