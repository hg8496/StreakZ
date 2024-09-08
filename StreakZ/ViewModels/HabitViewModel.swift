import Foundation
import Combine
import CoreData

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    private var cancellables: Set<AnyCancellable> = []

    private let habitService: HabitService

    init(context: NSManagedObjectContext) {
        self.habitService = HabitService(context: context)
        fetchHabits()
    }

    func fetchHabits() {
        habits = habitService.fetchHabits()
    }

    func addHabit(name: String, category: HabitCategory, startDate: Date, frequency: String, reminder: String, goalAmount: Int, goalPeriod: String) {
        habitService.addHabit(name: name, category: category, startDate: startDate, frequency: frequency, reminder: reminder, goalAmount: goalAmount, goalPeriod: goalPeriod)
        fetchHabits()
    }

    func toggleCompletion(for habit: Habit) {
        habitService.toggleCompletion(for: habit)
        fetchHabits()
    }
}
