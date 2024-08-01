//
//  ChartsView.swift
//  MoodScape
//
//  Created by mateo on 1/8/24.
//

import SwiftUI
import Charts

struct ChartsView: View {
    @State private var defaultSelectedSummary = "Weekly"
    private let summaryOptions = ["Daily", "Weekly", "Monthly"]
    private let dailyData: [Double] = [1, 2, 3, 4, 5, 6, 7]
    private let weeklyData: [Double] = [5, 5, 3, 2, 1, 3, 3]
    private let monthlyData: [Double] = [1, 3, 2, 4, 3, 5, 6, 7, 4, 3, 2, 1]

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack {
                Picker("Summary", selection: $defaultSelectedSummary) {
                    ForEach(summaryOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.black)

                ChartView(data: chartData, title: "\(defaultSelectedSummary) Summary")
                    .frame(height: 300)
                    .padding()
                    .background(Color.black)
                    .chartStyle()
                
//                Spacer()
                
                HStack {
                    ShareLink(item: "Check out this mood summary!") {
                        Label("", systemImage: "square.and.arrow.up")
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Add action here
                    }) {
                        Label("", systemImage: "list.bullet")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
            }
            .foregroundColor(.white) // Set text color to white
            .preferredColorScheme(.dark)
        }
    }

    private var chartData: [Double] {
        switch defaultSelectedSummary {
        case "Daily":
            return dailyData
        case "Weekly":
            return weeklyData
        case "Monthly":
            return monthlyData
        default:
            return []
        }
    }
}

struct ChartView: View {
    let data: [Double]
    let title: String

    var body: some View {
        Chart {
            ForEach(Array(data.enumerated()), id: \.0) { index, value in
                LineMark(
                    x: .value("Index", index + 1),
                    y: .value("Value", value)
                )
                .foregroundStyle(.yellow) // Line color
            }
        }
        .chartXAxis {
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

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
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
