//
//  MChartCoordinates.swift
//  MoodScape
//
//  Created by Santiago Mendoza on 31/8/24.
//

import Foundation

protocol MChartCoordinates {
    func x(_ type: SummaryType) -> Int
    var y: Double { get }
}
