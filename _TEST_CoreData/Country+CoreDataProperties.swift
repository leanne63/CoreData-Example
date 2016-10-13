//
//  Country+CoreDataProperties.swift
//  _TEST_CoreData
//
//  Created by leanne on 10/12/16.
//  Copyright © 2016 leanne63. All rights reserved.
//

import Foundation
import CoreData

extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country");
    }

    @NSManaged public var code: String?
    @NSManaged public var manufacturers: Manufacturer?

}
