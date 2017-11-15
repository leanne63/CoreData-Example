//
//  Country+CoreDataProperties.swift
//  CoreData-Example
//
//  Created by leanne on 10/18/16.
//  Copyright © 2016 leanne63. All rights reserved.
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country");
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var manufacturers: NSSet?

}

// MARK: Generated accessors for manufacturers
extension Country {

    @objc(addManufacturersObject:)
    @NSManaged public func addToManufacturers(_ value: Manufacturer)

    @objc(removeManufacturersObject:)
    @NSManaged public func removeFromManufacturers(_ value: Manufacturer)

    @objc(addManufacturers:)
    @NSManaged public func addToManufacturers(_ values: NSSet)

    @objc(removeManufacturers:)
    @NSManaged public func removeFromManufacturers(_ values: NSSet)

}
