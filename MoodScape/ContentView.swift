//
//  ContentView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationView {
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
                    
    //                              ZStack {
    //                                  Color.clear
    //                                      .frame(width: 100, height: 100) // Adjust size as needed
    //                
    //                                  MoodDropView()
    //                              }
    //                              .frame(maxWidth: 200, maxHeight: 200)
                    
                    Spacer().frame(height: 20)
                    
                    RatingView()
                    
                    Spacer()
                    
                    
                    NavigationLink(destination: HistoryView()) {
                        Text("Summary")
                            .bold()
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 130, height: 50)
                            .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.gray))
                            .shadow(radius: 10)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Register.self, configurations: config)
    
    return ContentView()
        .modelContainer(container)
}
