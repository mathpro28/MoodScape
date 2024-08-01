//
//  ChartsView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 16/7/24.
//

import SwiftUI
import SwiftUICharts

struct ChartsView: View {
    @State private var defaultSelectedSummary = "Weekly"
    private let summaryOptions = ["Daily", "Weekly", "Monthly"]

    var body: some View {
        VStack {
//            Text("Summary")
//                .bold()
//                .foregroundColor(.black)
//                .font(.largeTitle)
//                .padding()
            
            Picker("Summary", selection: $defaultSelectedSummary) {
                ForEach(summaryOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if defaultSelectedSummary == "Daily" {
                // Insert daily summary content here
                LineView(data: [1, 2, 3, 4, 5, 6, 7], title: "Daily Summary", legend: "Mood")
                    .frame(height: 300)
                    .padding()
            } else if defaultSelectedSummary == "Weekly" {
                // Weekly summary content
                LineView(data: [5, 5, 3, 2, 1, 3, 3], title: "Weekly Summary", legend: "Mood")
                    .frame(height: 300)
                    .padding()
            } else if defaultSelectedSummary == "Monthly" {
                // Insert monthly summary content here
                LineView(data: [1, 3, 2, 4, 3, 5, 6, 7, 4, 3, 2, 1], title: "Monthly Summary", legend: "Mood")
                    .frame(height: 300)
                    .padding()
            }
        }
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
