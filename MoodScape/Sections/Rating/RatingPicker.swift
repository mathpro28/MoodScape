//
//  RatingPicker.swift
//  MoodScape
//
//  Created by Santiago Mendoza on 31/8/24.
//

import SwiftUI
import SwiftData

struct RatingPicker: View {
    @Environment(\.modelContext) private var context
    @State private var rating: Int = 0

    private func onSubmit() {
        let newEntry = Register(value: rating, date: .now)
        context.insert(newEntry)
        print("Rating submitted: \(rating)")
    }

    var body: some View {
        MoodsView(rating: rating)
        RatingView(rating: $rating)
        if rating > 0 {
            MButton(systemName: "checkmark") {
                onSubmit()
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Register.self, configurations: config)
    return RatingPicker()
        .modelContainer(container)
}
