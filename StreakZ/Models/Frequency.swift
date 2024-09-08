//
//  Frequency.swift
//  StreakZ
//
//  Created by Christian Stolz on 08.09.24.
//

enum Frequency: String, CaseIterable, Identifiable {
    case daily = "daily"
    case weekly = "weekly"
    case monthly = "monthly"
    
    var id: String { self.rawValue }
}
