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
    @State private var rating: Int = 5
    
    var body: some View {
        NavigationView {
            ZStack {
                // Use ZStack to layer content on top of the background
                LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea(.all) // Extend gradient to entire screen
                
                VStack {
                    Spacer().frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    
                    Text("How are you feeling ")
                        .bold()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    + Text("today?")
                        .bold()
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    MoodsView(rating: $rating)
                    
                    RatingView()
                    
                    NavigationLink(destination: ChartsView()) {
                        Image(systemName: "arrow.right")
                            .bold()
                            .foregroundColor(.white)
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
