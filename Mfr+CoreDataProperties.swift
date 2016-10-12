//
//  Mfr+CoreDataProperties.swift
//  _TEST_CoreData
//
//  Created by leanne on 10/12/16.
//  Copyright © 2016 leanne63. All rights reserved.
//

import Foundation
import CoreData
import 

extension Mfr {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mfr> {
        return NSFetchRequest<Mfr>(entityName: "Mfr");
    }

    @NSManaged public var name: String?
    @NSManaged public var products: NSSet?
    @NSManaged public var country: Country?

}

// MARK: Generated accessors for products
extension Mfr {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}
