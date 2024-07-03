//
//  MoodDataManager.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 3/7/24.
//

import Foundation
import RealmSwift

class MoodDataManager: ObservableObject {
    private var realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func fetchMoodEntries(from startDate: Date, to endDate: Date) -> Results<MoodEntry> {
        return realm.objects(MoodEntry.self).filter("date >= %@ AND date < %@", startDate, endDate)
    }
    
    func fetchWeeklyData() -> Results<MoodEntry> {
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: Date())!.start
        let endOfWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: startOfWeek)!
        return fetchMoodEntries(from: startOfWeek, to: endOfWeek)
    }
    
    func fetchMonthlyData() -> Results<MoodEntry> {
        let calendar = Calendar.current
        let startOfMonth = calendar.dateInterval(of: .month, for: Date())!.start
        let endOfMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)!
        return fetchMoodEntries(from: startOfMonth, to: endOfMonth)
    }
    
    func fetchAnnualData() -> Results<MoodEntry> {
        let calendar = Calendar.current
        let startOfYear = calendar.dateInterval(of: .year, for: Date())!.start
        let endOfYear = calendar.date(byAdding: .year, value: 1, to: startOfYear)!
        return fetchMoodEntries(from: startOfYear, to: endOfYear)
    }
}
