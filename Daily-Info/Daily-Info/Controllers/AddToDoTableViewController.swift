//
//  AddToDoTableViewController.swift
//  Daily-Info
//
//  Created by Ruben  De Freyne on 29/12/2019.
//  Copyright © 2019 Ruben  De Freyne. All rights reserved.
//

import UIKit

class AddToDoTableViewController: UITableViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompletedButton: UIButton!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePickerView: UIDatePicker!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    func updateSaveButtonState(){
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompletedButton.isSelected = !isCompletedButton.isSelected
    }
}
