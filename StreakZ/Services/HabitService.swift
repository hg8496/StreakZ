import Foundation
import CoreData

class HabitService {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchHabits() -> [Habit] {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Habit.creationDate, ascending: true)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch habits: (error)")
            return []
        }
    }
    
    func markHabitAsDone(for habit: Habit) {
        let completion = HabitCompletion(context: context)
        completion.timestamp = Date()
        completion.habit = habit
        
        habit.addToCompletions(completion)
        updateStreak(for: habit)
        saveContext()
    }
    
    private func updateStreak(for habit: Habit) {
        let goalPeriod = habit.habitGoalPeriod;
        let completions = habit.completions?.array as? [HabitCompletion] ?? []
        
        let calendar = Calendar.current
        let periodComponents: Set<Calendar.Component>
        switch goalPeriod {
        case .day: periodComponents = [.day]
        case .week: periodComponents = [.weekOfYear]
        case .month: periodComponents = [.month]
        }
        
        // Group completions by goal period
        let groupedCompletions = Dictionary(grouping: completions, by: { completion in
            calendar.dateComponents(periodComponents, from: completion.timestamp ?? Date())
        })
        
        let sortedKeys = groupedCompletions.keys.sorted { lhs, rhs in
            let date1 = calendar.date(from: lhs) ?? Date.distantPast
            let date2 = calendar.date(from: rhs) ?? Date.distantPast
            return date1 < date2
        }
        
        // Calculate streak
        // Assuming streak is the count of continuous period within which each period has goalAmount completions
        var streak = 0
        var periodDate = Date()
        for dateComponents in sortedKeys {
            if let completionsForPeriod = groupedCompletions[dateComponents],
               completionsForPeriod.count >= habit.goalAmount {
                streak += 1
                periodDate = calendar.date(from: dateComponents) ?? Date()
            } else if let startDate = habit.creationDate, periodDate < startDate {
                break // If the period is before habit creation, skip the streak count
            } else {
                // Break streak if a required period with enough completions is missing
                break
            }
        }
        
        habit.streak = Int32(streak)
    }
    func addHabit(name: String, category: HabitCategory, startDate: Date, frequency: Frequency, reminder: String, goalAmount: Int, goalPeriod: GoalPeriod) {
        let newHabit = Habit(context: context)
        newHabit.name = name
        newHabit.creationDate = startDate
        newHabit.isCompleted = false
        newHabit.streak = 0
        newHabit.habitCategory = category
        newHabit.habitFrequency = frequency
        newHabit.reminder = reminder
        newHabit.goalAmount = Int32(goalAmount)
        newHabit.habitGoalPeriod = goalPeriod
        
        saveContext()
    }
    
    func toggleCompletion(for habit: Habit) {
        habit.isCompleted.toggle()
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: (error)")
        }
    }
}
