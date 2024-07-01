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
          Spacer()
        Text("How are you feeling today?")
              .bold()
              .foregroundStyle(.white)
              .font(.largeTitle)
              .frame(alignment: .trailing)
          Spacer()
        RatingView()
        Spacer()
      }
      .padding()
    }
  }
}


#Preview {
    ContentView()
}
