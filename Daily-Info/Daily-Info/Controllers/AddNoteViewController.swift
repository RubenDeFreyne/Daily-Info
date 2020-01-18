//
//  AddNoteViewController.swift
//  Daily-Info
//
//  Created by Ruben  De Freyne on 18/01/2020.
//  Copyright © 2020 Ruben  De Freyne. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    @IBOutlet var titleText: UITextField!
    @IBOutlet var contentText: UITextView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var note: Note?
    
    @IBAction func titleChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState(){
        let text = titleText.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let note = note {
            navigationItem.title = "Note"
            titleText.text = note.title
            contentText.text = note.content
        }
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleText.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let title = titleText.text!
        let content = contentText.text!
        
        note = Note(title: title, content: content)
    }
}
