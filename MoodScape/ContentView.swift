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
    @State private var rating: Int = 0 // State for rating
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea(.all)
                
                VStack {
                    Spacer().frame(height: 100)
                    
                    Text("How are you feeling ")
                        .bold()
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    + Text("today?")
                        .bold()
                        .foregroundColor(.yellow)
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    MoodsView(rating: rating) // Pass the rating to MoodsView
                    
                    RatingView(rating: $rating) // Pass the binding of rating to RatingView
                    
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
