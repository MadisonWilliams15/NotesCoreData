//
//  Note+CoreDataClass.swift
//  Notes
//
//  Created by Madison Williams on 7/26/18.
//  Copyright © 2018 Madison Williams. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Note)
public class Note: NSManagedObject {

    convenience init?(title : String?, contents : String?, date : String){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{
            return nil
        }
        self.init(entity: Note.entity() , insertInto: managedContext)
        
        self.title = title
        self.contents = contents
        self.date = date
        
        
    }
    
    
}
