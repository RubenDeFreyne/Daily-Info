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
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("notes").appendingPathExtension("plist")
    
    static func loadNotes()-> [Note]? {
        guard let codedNotes = try? Data(contentsOf: ArchiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Note>.self, from: codedNotes)
    }
    
    
    static func loadSampleNotes() -> [Note] {
        let note = Note(title: "Note One", content: "content")
        
        return [note]
    }
    
    static func saveNotes(_ notes: [Note]){
        let propertyListEncoder = PropertyListEncoder()
        let codedNotes = try? propertyListEncoder.encode(notes)
        try? codedNotes?.write(to: ArchiveURL, options: .noFileProtection)
    }
}
