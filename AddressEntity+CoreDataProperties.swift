//
//  AddressEntity+CoreDataProperties.swift
//  TableView
//
//  Created by Godhuli Sarkar on 16/03/23.
//
//

import Foundation
import CoreData


extension AddressEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressEntity> {
        return NSFetchRequest<AddressEntity>(entityName: "AddressEntity")
    }

    @NSManaged public var zipcode: String?
    @NSManaged public var city: String?
    @NSManaged public var street: String?

}

extension AddressEntity : Identifiable {

}
