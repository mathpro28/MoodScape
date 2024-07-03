//
//  MoodEntry.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 3/7/24.
//

import SwiftUI
import RealmSwift

class MoodEntry: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: Date = Date()
    @Persisted var moodScale: Int = 1
}
