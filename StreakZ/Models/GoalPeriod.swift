//
//  GoalPeriod.swift
//  StreakZ
//
//  Created by Christian Stolz on 08.09.24.
//

enum GoalPeriod: String, CaseIterable, Identifiable {
    case day = "day"
    case week = "week"
    case month = "month"

    var id: String { self.rawValue }
}
