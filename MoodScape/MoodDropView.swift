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
    @State private var offsets: [CGFloat] = []
    
    var body: some View {
        ZStack {
            ForEach(0..<randomMoods.count, id: \.self) { index in
                Text(randomMoods[index])
                    .font(.footnote)
                    .bold()
                    .offset(y: offsets[index])
                    .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false), value: offsets[index])
            }
        }
        .onAppear(perform: startDroppingMoods)
    }
    
    func startDroppingMoods() {
        randomMoods = moods.keys.shuffled().prefix(5).map { $0 }
        offsets = Array(repeating: -100, count: randomMoods.count)
        
        for i in 0..<randomMoods.count {
            withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false).delay(Double(i) * 0.5)) {
                offsets[i] = UIScreen.main.bounds.height + 100
            }
        }
    }
}

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("How are you feeling today?")
//                .bold()
//                .foregroundColor(.white)
//                .font(.largeTitle)
//                .frame(alignment: .trailing)
//            MoodDropView()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//        }
//        .background(Color.black.edgesIgnoringSafeArea(.all))
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


#Preview {
    MoodDropView()
}
