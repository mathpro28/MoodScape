//
//  RatingView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import SwiftUI

struct RatingView: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var rating: Int = 0

    var body: some View {
        VStack {
            HStack(spacing: 5) {
                ForEach(1...5, id: \.self) { number in
                    Text("\(number)")
                        .frame(width: 40, height: 40) // Adjust the size of the box
                        .background(number <= rating ? Color.yellow : Color.gray) // Change background color based on rating
                        .foregroundColor(.white) // Text color
                        .cornerRadius(5) // Rounded corners for the box
                        .onTapGesture {
                            rating = number
                        }
                }
            }
            .padding(.bottom, 20) // Add specific padding here

            Button(action: {
                _ = Register(value: rating, date: .now)
            }) {
                Text("Submit")
                    .bold()
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 130, height: 50)
                    .background(RoundedRectangle(cornerRadius: 20).foregroundColor(rating > 0 ? Color.gray : Color.gray.opacity(0.5)))
                    .shadow(radius: 10)
            }
            .disabled(rating == 0) // Disable the button if rating is not set
        }
        .padding()
    }
}

#Preview {
    RatingView()
}
