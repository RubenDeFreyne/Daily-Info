//
//  NotesViewController.swift
//  Daily-Info
//
//  Created by Ruben  De Freyne on 18/01/2020.
//  Copyright © 2020 Ruben  De Freyne. All rights reserved.
//

import UIKit

class NotesViewController: UITableViewController {
    
    var notes = [Note]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCellIdentifier", for: indexPath)
        
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.title
        
        return cell
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        if let savedNotes = Note.loadNotes() {
            notes = savedNotes
        } else {
            notes = Note.loadSampleNotes()
        }
        
        //navigationItem.leftBarButtonItem = editButtonItem
    }
}
