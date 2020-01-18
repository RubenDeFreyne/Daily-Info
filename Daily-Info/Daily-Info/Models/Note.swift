//
//  Note.swift
//  Daily-Info
//
//  Created by Ruben  De Freyne on 18/01/2020.
//  Copyright © 2020 Ruben  De Freyne. All rights reserved.
//

import Foundation
import CoreData

struct Note : Codable {
    var title: String
    var content: String
    
    static func loadNotes()-> [Note]? {
        return nil
    }
    
    
    static func loadSampleNotes() -> [Note] {
        let note = Note(title: "Note One", content: "content")
        
        return [note]
    }
}
