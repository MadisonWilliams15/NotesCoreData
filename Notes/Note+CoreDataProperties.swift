//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Madison Williams on 7/26/18.
//  Copyright © 2018 Madison Williams. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var contents: String?
    @NSManaged public var date: String?

}
