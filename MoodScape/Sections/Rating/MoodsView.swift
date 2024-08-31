//
//  MoodsView.swift
//  MoodScape
//
//  Created by mateo mercado on 7/8/24.
//

import SwiftUI

struct MoodsView: View {
    var rating: Int

    var ratingImageName: String {
        "mood_\(rating > 0 && rating < 6 ? rating.description : "default")"
    }

    var body: some View {
        Image(ratingImageName)
            .resizable()
            .frame(width: 150, height: 150)
            .foregroundColor(.white)
            .preferredColorScheme(.dark)
    }
}

#Preview {
    ScrollView(.horizontal) {
        HStack {
            ForEach((0...5), id: \.self) {
                MoodsView(rating: $0)
            }
        }
    }
    .scrollIndicators(.hidden)
}
