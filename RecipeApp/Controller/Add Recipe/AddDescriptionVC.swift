//
//  AddDescriptionVC.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 08..
//

import UIKit

class AddDescriptionVC: UIViewController {
    private var addDescriptionView = AddDescriptionView()
    var steps = [""]

    var delegate: DescriptionDelegate?
    
    override func loadView() {
        view = addDescriptionView
        title = "Description"
        sheetPresentationController?.prefersGrabberVisible = true
        
        addDescriptionView.tableView.register(DescriptionStepCell.self, forCellReuseIdentifier: DescriptionStepCell.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        addTargets()
        setDelegates()
    }
    
    private func addTargets() {
        addDescriptionView.addTarget(self, action: #selector(backgroundTapped), for: .touchUpInside)
        addDescriptionView.addCellButton.addTarget(self, action: #selector(addCell), for: .touchUpInside)
        addDescriptionView.submitComponent.submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
    }
    
    private func setDelegates() {
        addDescriptionView.tableView.dataSource = self
        addDescriptionView.tableView.delegate = self
    }
    
    private func configureTableView() {
        if steps.count == 0 {
            steps.append("")
            addDescriptionView.tableView.reloadData()
        }
    }
    
    @objc private func addCell() {
        if steps.last?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
            return
        }

        steps.append("")
        addDescriptionView.tableView.reloadData()
    }
    
    @objc private func submitButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc private func backgroundTapped() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            addDescriptionView.setKeyboardShownLayout(with: keyboardSize.height)
         }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        addDescriptionView.setKeyboardHiddenLayout()
    }
        
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//      if last step is empty, remove it, its unnecessary
        if steps.last?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
            steps.removeLast()
        }
        NotificationCenter.default.removeObserver(self)

        delegate?.pass(description: steps)
    }
}

extension AddDescriptionVC: UITableViewDataSource, UITableViewDelegate{
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionStepCell.id, for: indexPath) as! DescriptionStepCell
        cell.stepTextView.text = steps[indexPath.section]
        cell.stepTextView.tag = indexPath.section
        cell.stepTextView.delegate = self
        
        if indexPath.section == steps.count - 1 {
            cell.stepTextView.becomeFirstResponder()
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Step\(section + 1)"
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension AddDescriptionVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        steps[textView.tag] = textView.text
    }
}
