//
//  ChartsView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 16/7/24.
//

import SwiftUI
import SwiftUICharts

struct ChartsView: View {
    @Environment(\.modelContext) private var context
    
    var body: some View {
        
        VStack {
            Text("Summary")
                .bold()
                .foregroundColor(.black)
                .font(.largeTitle)
                .padding()
            
            // Line chart with data points
            LineView(data: [5, 5, 3, 2, 1, 3, 3], title: "Weekly Summary", legend: "Mood")
                .frame(height: 300)
                .padding()
        }
    }
}

struct LineChartExample_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}


