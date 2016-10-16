//
//  Product+CoreDataProperties.swift
//  _TEST_CoreData
//
//  Created by leanne on 10/16/16.
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

}
