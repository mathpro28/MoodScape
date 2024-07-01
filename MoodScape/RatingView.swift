//
//  RatingView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import RealmSwift
import SwiftUI

import SwiftUI

struct RatingView: View {
    @State private var rating: Int = 0
    @State private var showWarning: Bool = false

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
                            showWarning = false // Hide warning when a number is selected
                        }
                }
            }
            .padding(.bottom, 20) // Add specific padding here

            Button(action: {
                if rating > 0 {
                    print("Rating submitted: \(rating)")
                } else {
                    showWarning = true
                }
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

            if showWarning {
                Text("Please select a rating before submitting.")
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
        }
        .padding()
    }
}



#Preview {
    RatingView()
}
