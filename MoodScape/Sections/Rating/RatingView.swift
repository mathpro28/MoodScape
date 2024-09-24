//
//  RatingView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import SwiftUI
import SwiftData

struct RatingView: View {
    @Binding var rating: Int // Binding to update rating in ContentView
    
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                ForEach(1...5, id: \.self) { number in
                    RatingButton(number: number)
                }
            }
            .padding(.bottom, 20)
        }
        .padding()
        .foregroundStyle(Color.white)
        .preferredColorScheme(.dark)
    }

    @ViewBuilder
    private func RatingButton(number: Int) -> some View {
        Button {
            withAnimation {
                rating = number
            }
        } label: {
            Text("\(number)")
                .frame(width: 40, height: 40)
                .background(number <= rating ? Color.yellow : Color.gray)
                .foregroundStyle(number <= rating ? Color.cAirForceBlue : Color.white)
                .cornerRadius(5)
        }
    }
}

#Preview {
    RatingView(rating: .constant(3))
    
}
