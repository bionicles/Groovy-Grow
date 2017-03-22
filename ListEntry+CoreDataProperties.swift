//
//  ListEntry+CoreDataProperties.swift
//  Groovy Grow
//
//  Created by Bion Howard on 3/22/17.
//  Copyright © 2017 groovy grow. All rights reserved.
//

import Foundation
import CoreData


extension ListEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListEntry> {
        return NSFetchRequest<ListEntry>(entityName: "ListEntry");
    }

    @NSManaged public var name: String?

}
