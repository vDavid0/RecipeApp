//
//  ScanViewController.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 03. 12..
//
import UIKit

class ScanVC: UIViewController {
    private var scanView = ScanView()

    private var ingredients = [Ingredients]() { // ingredients added so far
        didSet {
            scanView.nextButton.setBadge(to: ingredients.count)
        }
    }
    
    override func loadView() {
        view = UIView()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Scan", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .label

        view.addSubview(scanView)
        scanView.pinBottomSafe(to: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        setCapturing()
    }
    
    private func addTargets() {
        scanView.scanButton.addTarget(self, action: #selector(startScanning), for: .touchUpInside)
        scanView.nextButton.addTarget(self, action: #selector(showIngredientsVC), for: .touchUpInside)
    }
    
//  Start one image classification process on the image, which the camera sees
    @objc private func startScanning() {
        ImageClassifier.shared.scan()
    }
    
//  Navigate to added ingredients list
    @objc private func showIngredientsVC() {
        let ingredientsVC = IngredientsVC()
        ingredientsVC.ingredients = ingredients
        ingredientsVC.delegate = self
        present(ingredientsVC, animated: true)
    }
    
    private func setCapturing() {
        ImageClassifier.shared.delegate = self
        ImageClassifier.shared.setupCaptureSession()
    }
    
    private func add(ingreditent: Ingredients) {
        if !ingredients.contains(ingreditent) {
            ingredients.append(ingreditent)
        }
    }
    
    private func showResultAlert() {
        guard let newIngredient = ImageClassifier.shared.result else {return}
        
        let ac = UIAlertController(title: newIngredient.rawValue, message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Add ingredient", style: .default, handler: { [weak self] _ in
            self?.add(ingreditent: newIngredient)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ImageClassifier.shared.startCapturing()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ImageClassifier.shared.stopCapturing()
    }
}

extension ScanVC: IngredientRecognisedDelegate, IngredientsDelegate {
// MARK: - IngredientRecognisedDelegate
    func ingredientRecognised(ingredient: Ingredients?) { //when image classifier returns a result
        showResultAlert()
    }
    
// MARK: - IngredientsDelegate
    func pass(ingredients: [Ingredients]) { //pass (manually added) ingredients from IngredientsVC
        self.ingredients = ingredients
    }
    
    func submitIngredients() { // show recipes which contain the provided ingredients
        let videoVC = MainRecipeStackVC()
        videoVC.modalPresentationStyle = .fullScreen // or .pageSheet
        navigationController?.pushViewController(videoVC, animated: true)
    }
}
