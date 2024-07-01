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

    var body: some View {
        ZStack {
            ForEach(0..<randomMoods.count, id: \.self) { index in
                Text(randomMoods[index])
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(.white)
                    .offset(offsets[index])
                    .animation(Animation.linear(duration: 5).repeatForever(autoreverses: true), value: offsets[index])
            }
        }
        .onAppear(perform: startDroppingMoods)
    }

    func startDroppingMoods() {
        randomMoods = moods.keys.shuffled().prefix(5).map { $0 }
        offsets = Array(repeating: CGSize(width: -UIScreen.main.bounds.width, height: 0), count: randomMoods.count)

        for i in 0..<randomMoods.count {
            let yPosition = CGFloat(i) * 50 // Adjust vertical spacing
            offsets[i] = CGSize(width: -UIScreen.main.bounds.width, height: yPosition)
            withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false).delay(Double(i) * 0.5)) {
                offsets[i] = CGSize(width: UIScreen.main.bounds.width + 100, height: yPosition)
            }
        }
    }
}

#Preview {
    MoodDropView()
}
