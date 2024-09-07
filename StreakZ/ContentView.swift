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
                        Section(header: categoryHeader(title: category.rawValue, imageName: category.rawValue.lowercased()+"Icon")) {
                            ForEach(habits.filter { $0.habitCategory == category }) { habit in
                                habitRow(habit: habit)
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

    func categoryHeader(title: String, imageName: String) -> some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.bottom, 5)
        .overlay(Divider().background(Color.white), alignment: .bottom)
    }

    func habitRow(habit: Habit) -> some View {
        HStack {
            Text(habit.name ?? "")
                .font(.body)
                .foregroundColor(.white)
            Spacer()
            Text(habit.streak.formatted())
                .font(.body)
                .foregroundColor(.green)
            Button(action: {
                habit.isCompleted.toggle()
                do {
                    try viewContext.save()
                } catch {
                    // Handle error
                }
            }) {
                Image(systemName: habit.isCompleted ? "checkmark.square.fill" : "square")
                    .foregroundColor(habit.isCompleted ? .green : .white)
                    .font(.title2)
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        .frame(height: 40)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
