//
//  HistoryView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Register.date, order: .reverse) private var entries: [Register]
    
    var body: some View {
        VStack {
//            Text("History")
//                .bold()
//                .foregroundColor(.black)
//                .font(.largeTitle)
//                .padding()
            
            List(entries) { entry in
                EntryRow(entry: entry)
            }
            .listStyle(.plain)
        }
        .padding()
        .navigationTitle("List Summary")
    }

    @ViewBuilder
    func EntryRow(entry: Register) -> some View {
        HStack {
            Text("Rating: \(entry.value)")
            Spacer()
            Text(entry.date, style: .date)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Register.self, configurations: config)

    // Insert some dummy data for preview purposes
    let entry1 = Register(value: 4, date: .now)
    let entry2 = Register(value: 3, date: .now.addingTimeInterval(-86400)) // 1 day ago

    container.mainContext.insert(entry1)
    container.mainContext.insert(entry2)

    return HistoryView()
        .modelContainer(container)
}
