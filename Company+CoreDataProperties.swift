//
//  Company+CoreDataProperties.swift
//  Groovy Grow
//
//  Created by Bion Howard on 3/22/17.
//  Copyright © 2017 groovy grow. All rights reserved.
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company");
    }

    @NSManaged public var address: String?
    @NSManaged public var id: Int16
    @NSManaged public var latitude: String?
    @NSManaged public var link: String?
    @NSManaged public var longitude: Int16
    @NSManaged public var name: String?
    @NSManaged public var products: String?
    @NSManaged public var schedule: String?
    @NSManaged public var type: String?

}
