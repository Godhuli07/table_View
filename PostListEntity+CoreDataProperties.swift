//
//  PostListEntity+CoreDataProperties.swift
//  TableView
//
//  Created by Godhuli Sarkar on 16/03/23.
//
//

import Foundation
import CoreData


extension PostListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostListEntity> {
        return NSFetchRequest<PostListEntity>(entityName: "PostListEntity")
    }

    @NSManaged public var body: String?
    @NSManaged public var title: String?
    @NSManaged public var id: Int64
    @NSManaged public var userId: Int64

}

extension PostListEntity : Identifiable {

}
