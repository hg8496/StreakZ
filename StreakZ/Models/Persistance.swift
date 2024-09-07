import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        // Create sample habits with different categories
        let categories: [HabitCategory] = [.morning, .noon, .evening]
        for i in 0..<9 {
            let newHabit = Habit(context: viewContext)
            newHabit.name = "Sample Habit " + (i + 1).formatted()
            newHabit.creationDate = Date()
            newHabit.isCompleted = false
            newHabit.streak = Int32(i)
            newHabit.habitCategory = categories[i % categories.count]
        }
        do {
            try viewContext.save()
        } catch {
            // Handle error
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Habits")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error (error), (error.userInfo)")
            }
        }
    }
}
