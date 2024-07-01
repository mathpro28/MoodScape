//
//  ContentView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import SwiftUI

struct ContentView: View {

  var body: some View {
    ZStack { // Use ZStack to layer content on top of the background
      LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .bottom, endPoint: .top)
        .ignoresSafeArea(.all) // Extend gradient to entire screen

      VStack {
//        Image(systemName: "figure.boxing")
//          .imageScale(.large)
//          .foregroundStyle(.tint)
        Text("How are you feeling today?")
              .bold()
              .foregroundStyle(.white)
              .font(.largeTitle)
              .frame(alignment: .trailing)
          Spacer()
        RatingsView(rating: 0)
        Spacer()
      }
      .padding()
    }
  }
}


#Preview {
    ContentView()
}
