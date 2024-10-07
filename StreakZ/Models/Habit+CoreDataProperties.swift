//
//  Habit+CoreDataProperties.swift
//  StreakZ
//
//  Created by Christian Stolz on 07.10.24.
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
    @NSManaged public var completions: NSOrderedSet?
    
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

// MARK: Generated accessors for completions
extension Habit {
    
    @objc(insertObject:inCompletionsAtIndex:)
    @NSManaged public func insertIntoCompletions(_ value: HabitCompletion, at idx: Int)
    
    @objc(removeObjectFromCompletionsAtIndex:)
    @NSManaged public func removeFromCompletions(at idx: Int)
    
    @objc(insertCompletions:atIndexes:)
    @NSManaged public func insertIntoCompletions(_ values: [HabitCompletion], at indexes: NSIndexSet)
    
    @objc(removeCompletionsAtIndexes:)
    @NSManaged public func removeFromCompletions(at indexes: NSIndexSet)
    
    @objc(replaceObjectInCompletionsAtIndex:withObject:)
    @NSManaged public func replaceCompletions(at idx: Int, with value: HabitCompletion)
    
    @objc(replaceCompletionsAtIndexes:withCompletions:)
    @NSManaged public func replaceCompletions(at indexes: NSIndexSet, with values: [HabitCompletion])
    
    @objc(addCompletionsObject:)
    @NSManaged public func addToCompletions(_ value: HabitCompletion)
    
    @objc(removeCompletionsObject:)
    @NSManaged public func removeFromCompletions(_ value: HabitCompletion)
    
    @objc(addCompletions:)
    @NSManaged public func addToCompletions(_ values: NSOrderedSet)
    
    @objc(removeCompletions:)
    @NSManaged public func removeFromCompletions(_ values: NSOrderedSet)
    
}

extension Habit : Identifiable {
    
}
