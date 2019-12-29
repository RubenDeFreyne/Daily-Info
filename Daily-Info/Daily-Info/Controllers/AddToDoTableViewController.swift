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
    
    var isPickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    
    let normalCellHeight : CGFloat = 44
    let largeCellHeight : CGFloat = 200
    
    var todo: ToDo?
    
    func updateSaveButtonState(){
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompletedButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        updateDueLabel(date: dueDatePickerView.date)
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
    
    func updateDueLabel(date: Date){
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    @IBAction func dueDatePickerChanged(_ sender: UIDatePicker) {
        updateDueLabel(date: dueDatePickerView.date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return isPickerHidden ? 0 : dueDatePickerView.frame.height
        default:
            return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateLabelIndexPath {
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let title = titleTextField.text!
        let isComplete = isCompletedButton.isSelected
        let dueDate = dueDatePickerView.date
        
        todo = ToDo(dueDate: dueDate, title: title, isComplete: isComplete)
    }
}
