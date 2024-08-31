//
//  SummaryType.swift
//  MoodScape
//
//  Created by Santiago Mendoza on 31/8/24.
//

import SwiftUI

enum SummaryType: String, CaseIterable, Identifiable {
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"

    var id: String {
        rawValue
    }

    var view: some View {
        Text(self.rawValue)
    }

    var xAxisLabel: String {
        switch self {
        case .daily:
            return "Hour"
        case .weekly:
            return "Day"
        case .monthly:
            return "Day"
        }
    }

    var calendarComponent: Calendar.Component {
        switch self {
        case .daily:
                .hour
        case .weekly:
                .weekday
        case .monthly:
                .day
        }
    }
}
