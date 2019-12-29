//
//  ToDoItem.swift
//  Daily-Info
//
//  Created by Ruben  De Freyne on 28/12/2019.
//  Copyright © 2019 Ruben  De Freyne. All rights reserved.
//

import Foundation
import CoreData

public class ToDoItem:NSManagedObject, Identifiable {
    @NSManaged public var dueDate:Date
    @NSManaged public var title: String
    @NSManaged public var isComplete: Bool
}

struct ToDo {
    var dueDate:Date
    var title: String
    var isComplete: Bool
    
    static func loadToDos()-> [ToDo]? {
        return nil
    }
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(dueDate: Date(), title: "ToDo One", isComplete: false)
        
        return [todo1]
    }
    
}



extension ToDoItem {
    static func getAllToDoItems() -> NSFetchRequest<ToDoItem> {
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest() as! NSFetchRequest<ToDoItem>
        
        //sort by created date
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
    
}
