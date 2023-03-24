//
//  TodoListEntity+CoreDataProperties.swift
//  TableView
//
//  Created by Godhuli Sarkar on 16/03/23.
//
//

import Foundation
import CoreData


extension TodoListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoListEntity> {
        return NSFetchRequest<TodoListEntity>(entityName: "TodoListEntity")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var title: String?
    @NSManaged public var id: Int64
    @NSManaged public var userId: Int64

}

extension TodoListEntity : Identifiable {

}
