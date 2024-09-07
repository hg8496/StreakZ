// ContentView.swift

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Habit.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.creationDate, ascending: true)]
    ) private var habits: FetchedResults<Habit>

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(HabitCategory.allCases) { category in
                        Section(header: CategoryHeader(title: category.rawValue, imageName: category.rawValue.lowercased()+"Icon")) {
                            ForEach(habits.filter { $0.habitCategory == category }) { habit in
                                HabitRow(habit: habit)
                            }
                            Spacer(minLength: 10)
                        }
                    }

                    Spacer()
                }
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(rgb: 0x031015), Color(rgb: 0x29373B)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .edgesIgnoringSafeArea(.all)
                )

                // Plus Button
                VStack {
                    Spacer()
                    HStack {
                        NavigationLink(destination: NewHabitView()) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 30)
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }

            }
            #if os(iOS)
            .navigationBarHidden(true)
            #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
