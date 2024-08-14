//
//  ChartsView.swift
//  MoodScape
//
//  Created by mateo mercado on 1/8/24.
//

import SwiftUI
import Charts
import SwiftData

struct ChartsView: View {
    @State private var defaultSelectedSummary = "Weekly"
    private let summaryOptions = ["Daily", "Weekly", "Monthly"]

    @Query(sort: \Register.date, order: .forward) private var registerData: [Register]
    
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

                ChartView(data: chartData, title: "\(defaultSelectedSummary) Summary", summaryType: SummaryType(rawValue: defaultSelectedSummary)!)
                    .frame(height: 300)
                    .padding()
                    .background(Color.black)
                    .chartStyle()
                
                HStack {
                    ShareLink(item: "Check out my mood summary!") {
                        Label("", systemImage: "square.and.arrow.up")
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: HistoryView()) {
                        Label("", systemImage: "list.bullet")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .navigationTitle("Charts Summary")
            }
            .foregroundColor(.white) // Set text color to white
            .preferredColorScheme(.dark)
        }
    }

    private var chartData: [(x: Int, y: Double)] {
        switch defaultSelectedSummary {
        case "Daily":
            return fetchData(for: .daily)
        case "Weekly":
            return fetchData(for: .weekly)
        case "Monthly":
            return fetchData(for: .monthly)
        default:
            return []
        }
    }

    private func fetchData(for summaryType: SummaryType) -> [(x: Int, y: Double)] {
        let calendar = Calendar.current
        let filteredData: [Register]
        
        switch summaryType {
        case .daily:
            filteredData = registerData.filter { calendar.isDateInToday($0.date) }
            return filteredData.map { (x: calendar.component(.hour, from: $0.date), y: Double($0.value)) }
        case .weekly:
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
            filteredData = registerData.filter { $0.date >= startOfWeek }
            return filteredData.map { (x: calendar.component(.weekday, from: $0.date), y: Double($0.value)) }
        case .monthly:
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
            filteredData = registerData.filter { $0.date >= startOfMonth }
            return filteredData.map { (x: calendar.component(.day, from: $0.date), y: Double($0.value)) }
        }
    }

    enum SummaryType: String {
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"
    }
}

struct ChartView: View {
    let data: [(x: Int, y: Double)]
    let title: String
    let summaryType: ChartsView.SummaryType

    var body: some View {
        Chart {
            ForEach(data, id: \.x) { point in
                PointMark(
                    x: .value(xAxisLabel, point.x),
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
    }

    private var xAxisLabel: String {
        switch summaryType {
        case .daily:
            return "Hour"
        case .weekly:
            return "Day"
        case .monthly:
            return "Day"
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
