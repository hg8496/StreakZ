//
//  HabitCompletion+CoreDataProperties.swift
//  StreakZ
//
//  Created by Christian Stolz on 07.10.24.
//
//

import Foundation
import CoreData


extension HabitCompletion {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HabitCompletion> {
        return NSFetchRequest<HabitCompletion>(entityName: "HabitCompletion.")
    }
    
    @NSManaged public var timestamp: Date?
    @NSManaged public var habit: Habit?
    
}

extension HabitCompletion : Identifiable {
    
}
