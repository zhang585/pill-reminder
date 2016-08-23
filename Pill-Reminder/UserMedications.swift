//
//  UserMedications.swift
//  Pill-Reminder
//
//  Created by Sandy Zhang on 8/20/16.
//  Copyright © 2016 Sandy Zhang. All rights reserved.
//

import UIKit
import CoreData


@objc(UserMedications)
class UserMedications: NSManagedObject {
    @NSManaged var medicationName: String
    @NSManaged var medicationStrength: String
    @NSManaged var date: String
    @NSManaged var type: String
    
}
