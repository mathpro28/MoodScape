//
//  ChartsView.swift
//  MoodScape
//
//  Created by mateo on 1/8/24.
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

                ChartView(data: chartData, title: "\(defaultSelectedSummary) Summary")
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

    private var chartData: [Double] {
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

    private func fetchData(for summaryType: SummaryType) -> [Double] {
        let calendar = Calendar.current
        let filteredData: [Register]
        
        switch summaryType {
        case .daily:
            filteredData = registerData.filter { calendar.isDateInToday($0.date) }
        case .weekly:
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
            filteredData = registerData.filter { $0.date >= startOfWeek }
        case .monthly:
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
            filteredData = registerData.filter { $0.date >= startOfMonth }
        }

        return filteredData.map { Double($0.value) }
    }

    enum SummaryType {
        case daily, weekly, monthly
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
