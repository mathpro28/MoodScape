//
//  MChartView.swift
//  MoodScape
//
//  Created by Santiago Mendoza on 31/8/24.
//

import SwiftUI
import Charts

struct MChartView<T: MChartCoordinates & Identifiable>: View {
    let data: [T]
    let title: String
    let summaryType: SummaryType

    var body: some View {
        Chart {
            ForEach(data) { point in
                PointMark(
                    x: .value(summaryType.xAxisLabel, point.x(summaryType)),
                    y: .value("Value", point.y)
                )
                .foregroundStyle(.yellow) // Line color
            }
        }
        .chartXAxis {
            AxisMarks(preset: .aligned, position: .bottom) { value in
                AxisGridLine().foregroundStyle(.gray)
                AxisTick().foregroundStyle(.gray)
                AxisValueLabel().foregroundStyle(.white) // Label color
            }
        }
        .chartYAxis {
            AxisMarks(preset: .aligned, position: .leading) { value in
                AxisGridLine().foregroundStyle(.gray)
                AxisTick().foregroundStyle(.gray)
                AxisValueLabel().foregroundStyle(.white) // Label color
            }
        }
        .chartStyle()
    }
}

#Preview {
    MChartView(data: [Register(value: 1, date: .now)], title: "Test", summaryType: .daily)
}

extension View {
    func chartStyle() -> some View {
        self.chartXAxis {
            AxisMarks(preset: .aligned, position: .bottom) { _ in
                AxisGridLine().foregroundStyle(.gray)
                AxisTick().foregroundStyle(.gray)
                AxisValueLabel().foregroundStyle(.white) // Label color
            }
        }
        .chartYAxis {
            AxisMarks(preset: .aligned, position: .leading) { _ in
                AxisGridLine().foregroundStyle(.gray)
                AxisTick().foregroundStyle(.gray)
                AxisValueLabel().foregroundStyle(.white) // Label color
            }
        }
    }
}
