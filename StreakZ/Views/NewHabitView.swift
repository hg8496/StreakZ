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
    @State private var selectedFrequency: Frequency = .daily
    @State private var reminder: String = "No"
    @State private var startDate: Date = Date()
    @State private var goalAmount: Int = 1
    @State private var goalPeriod: GoalPeriod = .day
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField(LocalizedStringKey("enter_habit_name"), text: $habitName)
                .foregroundColor(.white)
            Text(LocalizedStringKey("category"))
                .foregroundColor(.white)
                .font(.headline)
            
            Picker(LocalizedStringKey("category"), selection: $selectedCategory) {
                ForEach(HabitCategory.allCases) { category in
                    Text(LocalizedStringKey(category.rawValue.lowercased())).tag(category)
                }
            }
            
            Text(LocalizedStringKey("frequency"))
                .foregroundColor(.white)
                .font(.headline)
            
            Picker(LocalizedStringKey("frequency"), selection: $selectedFrequency) {
                ForEach(Frequency.allCases) { frequency in
                    Text(LocalizedStringKey(frequency.rawValue.lowercased())).tag(frequency)
                }
            }
            
            Text(LocalizedStringKey("reminder"))
                .foregroundColor(.white)
                .font(.headline)
            
            Picker(LocalizedStringKey("reminder"), selection: $reminder) {
                Text("no").tag("No")
                Text("yes").tag("Yes")
            }
            
            Text(LocalizedStringKey("start_date"))
                .foregroundColor(.white)
                .font(.headline)
            
            Text(LocalizedStringKey("goal"))
                .foregroundColor(.white)
                .font(.headline)
            
            HStack {
                Stepper(value: $goalAmount, in: 1...100) {
                    HStack {
                        Text(LocalizedStringKey("goalAmount"))
                            .foregroundColor(.white)
                        Text(goalAmount.formatted())
                            .foregroundColor(.white)
                    }
                }
                
                Text(LocalizedStringKey("per"))
                    .foregroundColor(.white)
                
                Picker(LocalizedStringKey("per"), selection: $goalPeriod) {
                    ForEach(GoalPeriod.allCases) { period in
                        Text(LocalizedStringKey(period.rawValue.lowercased())).tag(period)
                    }
                }
            }
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text(LocalizedStringKey("cancel"))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            
            Button(action: {
                viewModel.addHabit(name: habitName, category: selectedCategory, startDate: startDate, frequency: selectedFrequency, reminder: reminder, goalAmount: goalAmount, goalPeriod: goalPeriod)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text(LocalizedStringKey("add_habit"))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(radius: 5)
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
