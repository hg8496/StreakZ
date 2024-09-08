// ContentView.swift

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var viewModel: HabitViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(HabitCategory.allCases) { category in
                                Section(header: CategoryHeader(title: LocalizedStringKey(category.rawValue.lowercased()),
                                imageName: "\(category.rawValue.lowercased())Icon")) {
                                    ForEach(viewModel.habits.filter { $0.habitCategory == category }) { habit in
                                        HabitRow(habit: habit)
                                    }
                                    Spacer(minLength: 10)
                                }
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                        .frame(width: geometry.size.width)
                    }
                    .padding()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(rgb: 0x031015), Color(rgb: 0x29373B)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .edgesIgnoringSafeArea(.all)
                    )
                }

                // Plus Button
                VStack {
                    Spacer()
                    HStack {
                        NavigationLink(destination: NewHabitView()) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            Text(LocalizedStringKey("add_habit"))
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
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(HabitViewModel(context: PersistenceController.preview.container.viewContext))
    }
}
