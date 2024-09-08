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

    func addHabit(name: String, category: HabitCategory, startDate: Date, frequency: String, reminder: String, goalAmount: Int, goalPeriod: String) {
        let newHabit = Habit(context: context)
        newHabit.name = name
        newHabit.creationDate = startDate
        newHabit.isCompleted = false
        newHabit.streak = 0
        newHabit.habitCategory = category

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
