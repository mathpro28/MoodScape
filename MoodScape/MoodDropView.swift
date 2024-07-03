//
//  MoodDropView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 1/7/24.
//

import SwiftUI

struct MoodDropView: View {
    @State private var moods: [String: String] = [
        "Happy": "😊",
        "Sad": "😢",
        "Excited": "🤩",
        "Angry": "😠",
        "Relaxed": "😌",
        "Nervous": "😬",
        "Bored": "😐",
        "Surprised": "😲",
        "Tired": "😴",
        "Confused": "😕"
    ]
    @State private var randomMoods: [String] = []
    @State private var offsets: [CGSize] = []
    @State private var animationDuration: Double = 1.0

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                ForEach(0..<randomMoods.count, id: \.self) { index in
                    Text(randomMoods[index])
//                        .font(.custom("Courier New", size: 20))
                        .bold()
                        .shadow(radius: 0.1)
                        .foregroundColor(.white)
                        .offset(offsets[index])
                        .onAppear {
                            animateWord(at: index)
                        }
                }
            }
            .onAppear(perform: startDroppingMoods)
            Spacer()
        }
    }

        func startDroppingMoods() {
            randomMoods = moods.keys.shuffled().prefix(6).map { $0 }
            offsets = Array(repeating: CGSize(width: -UIScreen.main.bounds.width, height: 0), count: randomMoods.count)
            
            for i in 0..<randomMoods.count {
                let yPosition = CGFloat(i) * 20 // Adjust vertical spacing
                offsets[i] = CGSize(width: -UIScreen.main.bounds.width / 2 + 150, height: yPosition)
            }
        }

        func animateWord(at index: Int) {
            withAnimation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: true)) {
                offsets[index] = CGSize(width: UIScreen.main.bounds.width / 2 - 150, height: offsets[index].height)
            }
        }
}

#Preview {
    MoodDropView()
}
