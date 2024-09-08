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
    @NSManaged public var frequency: String?
    @NSManaged public var reminder: String?
    @NSManaged public var goalAmount: Int32
    @NSManaged public var goalPeriod: String?

    var habitCategory: HabitCategory {
        get {
            HabitCategory(rawValue: category ?? "") ?? .morning
        }
        set {
            category = newValue.rawValue
        }
    }

    var habitFrequency: Frequency {
        get {
            Frequency(rawValue: frequency ?? "") ?? .daily
        }
        set {
            frequency = newValue.rawValue
        }
    }

    var habitGoalPeriod: GoalPeriod {
        get {
            GoalPeriod(rawValue: goalPeriod ?? "") ?? .day
        }
        set {
            goalPeriod = newValue.rawValue
        }
    }
}

extension Habit : Identifiable {

}
