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
