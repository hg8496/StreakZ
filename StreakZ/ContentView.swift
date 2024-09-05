//
//  ContentView.swift
//  StreakZ
//
//  Created by Christian Stolz on 27.08.24.
//

import SwiftUI

struct Habit: Identifiable {
    let id = UUID()
    var title: String
    var count: Int
    var isChecked: Bool
}



struct NewHabitView: View {
    @State private var habitName: String = ""
    @State private var selectedTime: String = "Morning"
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
            
            Text("When")
                .foregroundColor(.white)
                .font(.headline)
            
            Picker("When", selection: $selectedTime) {
                Text("Morning").tag("Morning")
                Text("Noon").tag("Noon")
                Text("Evening").tag("Evening")
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.gray.opacity(0.2)) // Ändern Sie hier die Hintergrundfarbe
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
            .background(Color.gray.opacity(0.2)) // Ändern Sie hier die Hintergrundfarbe
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
                    Text("\(goalAmount)")
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
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Button(action: {
                    // Create Habit action
                }) {
                    Text("Create Habit")
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
                gradient: Gradient(colors: [Color(hex: "#031015"), Color(hex: "#29373B")]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .edgesIgnoringSafeArea(.all)
        )
    }
}

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 1)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}


struct ContentView: View {
    @State private var habits = [
        Habit(title: "Check Finances", count: 2, isChecked: false),
        Habit(title: "Workout", count: 1, isChecked: false),
        Habit(title: "Glass of cold Water", count: 3, isChecked: false),
        Habit(title: "Meditate", count: 1, isChecked: false),
        Habit(title: "Check E-Mails", count: 2, isChecked: false),
        Habit(title: "Journal", count: 1, isChecked: false),
        Habit(title: "To-Dos for tomorrow", count: 2, isChecked: false),
        Habit(title: "Practice Guitar", count: 3, isChecked: false),
        Habit(title: "Read 20 Mins", count: 7, isChecked: false)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 10) {
                    Section(header: categoryHeader(title: "Morning", imageName: "morningIcon")) {
                        ForEach(habits.indices.filter { $0 < 4 }, id: \.self) { index in
                            habitRow(habit: $habits[index])
                        }
                        Spacer(minLength: 10)
                    }
                    
                    Section(header: categoryHeader(title: "Noon", imageName: "noonIcon")) {
                        habitRow(habit: $habits[4])
                        Spacer(minLength: 10)
                    }
                    
                    Section(header: categoryHeader(title: "Evening", imageName: "moonIcon")) {
                        ForEach(habits.indices.filter { $0 > 4 }, id: \.self) { index in
                            habitRow(habit: $habits[index])
                        }
                        Spacer(minLength: 5)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "#031015"), Color(hex: "#29373B")]),
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
            .navigationBarHidden(true) // Verstecken Sie die NavigationBar
            #endif
        }
    }
    func categoryHeader(title: String, imageName: String) -> some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24) // Größe des Icons anpassen
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.bottom, 5)
        .overlay(Divider().background(Color.white), alignment: .bottom) // Divider als Overlay hinzufügen
    }
    
    func habitRow(habit: Binding<Habit>) -> some View {
        HStack {
            Text(habit.wrappedValue.title)
                .font(.body)
                .foregroundColor(.white)
            Spacer()
            Text("\(habit.wrappedValue.count)")
                .font(.body)
                .foregroundColor(.green)
            Button(action: {
                habit.wrappedValue.isChecked.toggle()
            }) {
                Image(systemName: habit.wrappedValue.isChecked ? "checkmark.square.fill" : "square")
                    .foregroundColor(habit.wrappedValue.isChecked ? .green : .white)
                    .font(.title2)
            }
        }
        .padding(.vertical, 5) // Vertikales Padding reduzieren
        .padding(.horizontal) // Optional: Horizontales Padding beibehalten
        .frame(height: 40) // Höhe des Rechtecks anpassen
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
