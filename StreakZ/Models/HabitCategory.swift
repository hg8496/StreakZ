enum HabitCategory: String, CaseIterable, Identifiable {
    case morning = "Morning"
    case noon = "Noon"
    case evening = "Evening"

    var id: String { self.rawValue }
}
