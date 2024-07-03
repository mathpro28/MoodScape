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
    @State private var animationDuration: Double = 7.0

    var body: some View {
        ZStack {
            ForEach(0..<randomMoods.count, id: \.self) { index in
                Text(randomMoods[index])
                    .font(.custom("Courier New", size: 15))
                    .bold()
                    .foregroundColor(.white)
                    .offset(offsets[index])
            }
        }
        .onAppear(perform: startDroppingMoods)
    }

    func startDroppingMoods() {
        randomMoods = moods.keys.shuffled().prefix(6).map { $0 }
        offsets = Array(repeating: CGSize(width: -UIScreen.main.bounds.width, height: 0), count: randomMoods.count)

        for i in 0..<randomMoods.count {
            let yPosition = CGFloat(i) * 20 // Adjust vertical spacing
            offsets[i] = CGSize(width: -UIScreen.main.bounds.width, height: yPosition)
            withAnimation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: true).delay(Double(i) * 0.2)) {
                offsets[i] = CGSize(width: UIScreen.main.bounds.width + 100, height: yPosition)
            }
        }
    }
}

#Preview {
    MoodDropView()
}
