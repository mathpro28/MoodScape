//
//  ChartsView.swift
//  MoodScape
//
//  Created by mateo mercado on 1/8/24.
//

import SwiftUI
import SwiftData

struct ChartsView: View {
    @State private var selectedSummary: SummaryType = .weekly
    private let summaryOptions = SummaryType.allCases

    @Query(sort: \Register.date, order: .forward) private var registerData: [Register]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack {
                PickerView()
                MChartView(data: chartData(), title: "\(selectedSummary) Summary", summaryType: selectedSummary)
                    .frame(height: 300)
                    .padding()
                    .background(Color.black)
                BottomView()
            }
        }
        .navigationTitle("Charts Summary")
        .preferredColorScheme(.dark)
        .foregroundStyle(Color.white)
    }

    @ViewBuilder
    func PickerView() -> some View {
        Picker("Summary", selection: $selectedSummary) {
            ForEach(summaryOptions) { type in
                type.view
                    .tag(type)
            }
        }
        .pickerStyle(.segmented)
        .padding()
        .background(Color.black)
    }

    @ViewBuilder
    func BottomView() -> some View {
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
    }
}

private extension ChartsView {
    func chartData() -> [Register] {
        let calendar = Calendar.current

        switch selectedSummary {
        case .daily:
            return registerData.filter { calendar.isDateInToday($0.date) }
        case .weekly:
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
            return registerData.filter { $0.date >= startOfWeek }
        case .monthly:
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
            return registerData.filter { $0.date >= startOfMonth }
        }
    }

}

#Preview {
    ChartsView()
}
