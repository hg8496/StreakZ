// StreakZApp.swift

import SwiftUI
import CoreData

@main
struct StreakZApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var habitViewModel = HabitViewModel(context: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(habitViewModel)
        }
    }
}
