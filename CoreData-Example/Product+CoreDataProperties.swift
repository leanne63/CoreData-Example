//
//  Product+CoreDataProperties.swift
//  CoreData-Example
//
//  Created by leanne on 10/18/16.
//  Copyright © 2016 leanne63. All rights reserved.
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product");
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var weight: Double
    @NSManaged public var manufacturer: Manufacturer?
    @NSManaged public var productDescriptions: NSSet?

}

// MARK: Generated accessors for productDescriptions
extension Product {

    @objc(addProductDescriptionsObject:)
    @NSManaged public func addToProductDescriptions(_ value: ProductDescription)

    @objc(removeProductDescriptionsObject:)
    @NSManaged public func removeFromProductDescriptions(_ value: ProductDescription)

    @objc(addProductDescriptions:)
    @NSManaged public func addToProductDescriptions(_ values: NSSet)

    @objc(removeProductDescriptions:)
    @NSManaged public func removeFromProductDescriptions(_ values: NSSet)

}
