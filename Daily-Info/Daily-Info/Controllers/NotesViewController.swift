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
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Note.saveNotes(notes)
        }
    }
    
    @IBAction func unwindNoteList(segue: UIStoryboardSegue){
        guard segue.identifier == "saveUnwind" else {return}
        
        let sourceViewController = segue.source as! AddNoteViewController
        
        if let note = sourceViewController.note {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                notes[selectedIndexPath.row] = note
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: notes.count, section: 0)
                notes.append(note)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        Note.saveNotes(notes)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditNote",
            let navController = segue.destination as? UINavigationController,
            let addNoteViewController = navController.topViewController as? AddNoteViewController {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedNote = notes[indexPath.row]
            addNoteViewController.note = selectedNote
        }
    }
}
