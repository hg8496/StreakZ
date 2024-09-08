enum HabitCategory: String, CaseIterable, Identifiable {
    case morning = "morning"
    case noon = "noon"
    case evening = "evening"

    var id: String { self.rawValue }
}
