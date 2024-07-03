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
              
              Text("How are you feeling ")
                  .bold()
                  .foregroundColor(.white)
                  .font(.largeTitle)
              + Text("today?")
                  .bold()
                  .foregroundColor(.yellow)
                  .font(.largeTitle)
              
              Spacer().frame(height: 20)
              
//              ZStack {
//                  Color.clear
//                      .frame(width: 100, height: 100) // Adjust size as needed
//                  
//                  MoodDropView()
//              }
//              .frame(maxWidth: 200, maxHeight: 200)
              
              Spacer().frame(height: 20)
              
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
