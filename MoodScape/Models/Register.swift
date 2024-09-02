//
//  Register.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 8/7/24.
//

import Foundation
import SwiftData

@Model
class Register {
    var value: Int
    var date: Date
    
    init(value: Int, date: Date) {
        self.value = value
        self.date = date
    }
}


// To support Chart implementation
extension Register: MChartCoordinates {
    func x(_ type: SummaryType) -> Int {
        Calendar.current.component(type.calendarComponent, from: self.date)
    }

    var y: Double {
        Double(self.value)
    }
}
