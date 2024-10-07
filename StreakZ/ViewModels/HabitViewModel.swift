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
    
    func addHabit(name: String, category: HabitCategory, startDate: Date, frequency: Frequency, reminder: String, goalAmount: Int, goalPeriod: GoalPeriod) {
        habitService.addHabit(name: name, category: category, startDate: startDate, frequency: frequency, reminder: reminder, goalAmount: goalAmount, goalPeriod: goalPeriod)
        fetchHabits()
    }
    
    func toggleCompletion(for habit: Habit) {
        habitService.toggleCompletion(for: habit)
        fetchHabits()
    }
    
    func markHabitAsDone(for habit: Habit) {
        habitService.markHabitAsDone(for: habit)
        fetchHabits()
    }
    
    func updateGoalPeriod(for frequency: Frequency) -> GoalPeriod {
        switch frequency {
        case .daily:
            return .day
        case .weekly:
            return .week
        case .monthly:
            return .month
        }
    }
}
