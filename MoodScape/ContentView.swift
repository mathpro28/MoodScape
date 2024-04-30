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
            Spacer()
            Image(systemName: "figure.boxing")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("How are you feeling today?")
            RatingsView(rating: 0)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
