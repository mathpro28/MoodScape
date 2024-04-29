//
//  ContentView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "figure.boxing")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("How are you feeling today?")
            RatingsView(rating: 3)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
