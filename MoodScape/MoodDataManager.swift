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
    
    func generateRandomMoodData(numberOfEntries: Int) {
            let calendar = Calendar.current
            let today = Date()
            
            try! realm.write {
                for _ in 0..<numberOfEntries {
                    let randomDaysOffset = Int.random(in: -365...0)
                    let randomDate = calendar.date(byAdding: .day, value: randomDaysOffset, to: today)!
                    let randomMoodScale = Int.random(in: 1...5)
                    
                    let moodEntry = MoodEntry()
                    moodEntry.date = randomDate
                    moodEntry.moodScale = randomMoodScale
                    
                    realm.add(moodEntry)
                }
            }
        }
}
