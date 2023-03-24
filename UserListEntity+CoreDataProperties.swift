//
//  UserListEntity+CoreDataProperties.swift
//  TableView
//
//  Created by Godhuli Sarkar on 16/03/23.
//
//

import Foundation
import CoreData


extension UserListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserListEntity> {
        return NSFetchRequest<UserListEntity>(entityName: "UserListEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var website: String?

}

extension UserListEntity : Identifiable {

}
