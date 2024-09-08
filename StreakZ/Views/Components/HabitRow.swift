import SwiftUI
import CoreData

struct HabitRow: View {
    @ObservedObject var habit: Habit
    @EnvironmentObject var viewModel: HabitViewModel

    var body: some View {
        HStack {
            Text(habit.name ?? "")
                .font(.body)
                .foregroundColor(.white)
            Spacer()
            Text(habit.streak.formatted())
                .font(.body)
                .foregroundColor(.green)
            Button(action: {
                viewModel.toggleCompletion(for: habit)
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

struct HabitRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let habit = Habit(context: context)
        habit.name = "Sample Habit"
        habit.streak = 5
        habit.isCompleted = false

        return HabitRow(habit: habit)
            .environment(\.managedObjectContext, context)
            .environmentObject(HabitViewModel(context: context))
            .background(Color.black)
            .previewLayout(.sizeThatFits)
    }
}
