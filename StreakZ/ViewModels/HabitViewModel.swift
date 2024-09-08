import Foundation
import CoreData
import Combine

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    private var cancellables: Set<AnyCancellable> = []

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchHabits()
    }

    func fetchHabits() {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Habit.creationDate, ascending: true)]

        do {
            habits = try context.fetch(request)
        } catch {
            print("Failed to fetch habits: (error)")
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
            fetchHabits()
        } catch {
            print("Failed to save context: (error)")
        }
    }
}
