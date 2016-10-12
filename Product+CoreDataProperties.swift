//
//  Product+CoreDataProperties.swift
//  _TEST_CoreData
//
//  Created by leanne on 10/12/16.
//  Copyright © 2016 leanne63. All rights reserved.
//

import Foundation
import CoreData
import 

extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product");
    }

    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var weight: NSDecimalNumber?
    @NSManaged public var mfr: Mfr?

}
