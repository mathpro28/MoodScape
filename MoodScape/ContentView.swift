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
    @State private var navigate: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                VStack {
                    Spacer()
                    HeaderView()
                    Spacer()
                    RatingPicker()
                    MButton(systemName: "arrow.right") {
                        navigate = true
                    }
                    Spacer()
                    HStack {
                        CameraView()
                        Spacer()
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: $navigate, destination: {
                ChartsView()
            })
        }
    }

    @ViewBuilder
    func Background() -> some View {
        LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .bottom, endPoint: .top)
            .ignoresSafeArea(.all)
    }

    @ViewBuilder
    func HeaderView() -> some View {
        Text("How are you feeling ")
            .bold()
            .foregroundStyle(Color.white)
            .font(.largeTitle)
        + Text("today?")
            .bold()
            .foregroundStyle(Color.yellow)
            .font(.largeTitle)
    }
    
    @ViewBuilder
    func CameraView() -> some View {
        Image(systemName: "camera")
            .font(.title)
            .foregroundStyle(Color.yellow)
            .padding()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Register.self, configurations: config)
    
    return ContentView()
        .modelContainer(container)
}
