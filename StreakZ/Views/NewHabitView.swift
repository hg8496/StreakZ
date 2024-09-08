//
//  NewHabitView.swift
//  StreakZ
//
//  Created by Christian Stolz on 07.09.24.
//

import SwiftUI

struct NewHabitView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: HabitViewModel
    @State private var habitName: String = ""
    @State private var selectedCategory: HabitCategory = .morning
    @State private var selectedFrequency: String = "Daily"
    @State private var reminder: String = "No"
    @State private var startDate: Date = Date()
    @State private var goalAmount: Int = 1
    @State private var goalPeriod: String = "Month"

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("Enter Habit Name", text: $habitName)
                .padding()
                .background(Color.white)
                .cornerRadius(5)

            Text("Category")
                .foregroundColor(.white)
                .font(.headline)

            Picker("Category", selection: $selectedCategory) {
                ForEach(HabitCategory.allCases) { category in
                    Text(LocalizedStringKey(category.rawValue.lowercased())).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5)

            Text("Frequency")
                .foregroundColor(.white)
                .font(.headline)

            Picker("Frequency", selection: $selectedFrequency) {
                Text("Daily").tag("Daily")
                Text("Weekly").tag("Weekly")
                Text("Monthly").tag("Monthly")
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5)

            Text("Reminder")
                .foregroundColor(.white)
                .font(.headline)

            Picker("Reminder", selection: $reminder) {
                Text("No").tag("No")
                Text("Yes").tag("Yes")
            }
            .pickerStyle(MenuPickerStyle())
            .background(Color.white)
            .cornerRadius(5)
            .padding(.horizontal)

            Text("Start Date")
                .foregroundColor(.white)
                .font(.headline)

            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                .padding(.horizontal)

            HStack {
                Text("Goal")
                    .foregroundColor(.white)
                    .font(.headline)

                Stepper(value: $goalAmount, in: 1...100) {
                    Text("(goalAmount)")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(5)

                Picker("Per", selection: $goalPeriod) {
                    Text("Day").tag("Day")
                    Text("Week").tag("Week")
                    Text("Month").tag("Month")
                }
                .pickerStyle(MenuPickerStyle())
                .background(Color.white)
                .cornerRadius(5)
                .padding(.horizontal)
            }

            HStack {
                Button(action: {
                    // Cancel action
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }

                Spacer()

                Button(action: {
                    viewModel.addHabit(name: habitName, category: selectedCategory, startDate: startDate, frequency: selectedFrequency, reminder: reminder, goalAmount: goalAmount, goalPeriod: goalPeriod)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("add_habit")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding(.top, 20)

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
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        return NewHabitView()
            .environment(\.managedObjectContext, context)
            .environmentObject(HabitViewModel(context: context))
    }
}
