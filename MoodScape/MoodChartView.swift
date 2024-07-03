//
//  MoodChartView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 3/7/24.
//

import SwiftUI
import SwiftUICharts
import RealmSwift

struct MoodChartView: View {
    @ObservedObject var dataManager = MoodDataManager()
    
    var body: some View {
        TabView {
            WeeklyMoodView(dataManager: dataManager)
                .tabItem {
                    Label("Weekly", systemImage: "calendar")
                }
            
            MonthlyMoodView(dataManager: dataManager)
                .tabItem {
                    Label("Monthly", systemImage: "calendar")
                }
            
            AnnualMoodView(dataManager: dataManager)
                .tabItem {
                    Label("Annual", systemImage: "calendar")
                }
        }
    }
    
    private func moodData(for entries: Results<MoodEntry>) -> [Double] {
        entries.map { Double($0.moodScale) }
    }
}

struct WeeklyMoodView: View {
    @ObservedObject var dataManager: MoodDataManager
    
    var body: some View {
        VStack {
            Text("Weekly Mood")
            LineChartView(data: moodData(for: dataManager.fetchWeeklyData()), title: "Weekly Mood", legend: "Scale")
                .padding()
        }
    }
    
    private func moodData(for entries: Results<MoodEntry>) -> [Double] {
        entries.map { Double($0.moodScale) }
    }
}

struct MonthlyMoodView: View {
    @ObservedObject var dataManager: MoodDataManager
    
    var body: some View {
        VStack {
            Text("Monthly Mood")
            LineChartView(data: moodData(for: dataManager.fetchMonthlyData()), title: "Monthly Mood", legend: "Scale")
                .padding()
        }
    }
    
    private func moodData(for entries: Results<MoodEntry>) -> [Double] {
        entries.map { Double($0.moodScale) }
    }
}

struct AnnualMoodView: View {
    @ObservedObject var dataManager: MoodDataManager
    
    var body: some View {
        VStack {
            Text("Annual Mood")
            LineChartView(data: moodData(for: dataManager.fetchAnnualData()), title: "Annual Mood", legend: "Scale")
                .padding()
        }
    }
    
    private func moodData(for entries: Results<MoodEntry>) -> [Double] {
        entries.map { Double($0.moodScale) }
    }
}

#Preview {
    MoodChartView()
}
