//
//  Habit+CoreDataProperties.swift
//  StreakZ
//
//  Created by Christian Stolz on 08.09.24.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var category: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var name: String?
    @NSManaged public var streak: Int32

    var habitCategory: HabitCategory {
        get {
            HabitCategory(rawValue: category ?? "") ?? .morning
        }
        set {
            category = newValue.rawValue
        }
    }
}

extension Habit : Identifiable {

}
