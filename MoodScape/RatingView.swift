//
//  RatingView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import RealmSwift
import SwiftUI

struct RatingsView: View {
    @State var rating:Int
//    let action: () -> Void
  
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 5) { // Add spacing between stars for better tapping experience
                ForEach(1...5, id: \.self) { number in
                    Image(systemName: number <= rating ? "star.fill" : "star")
                        .foregroundColor(Color.yellow)
                        .onTapGesture {
                            rating = number // Update rating on tap
                        }
                }
            }
            Button {
                // Perform button action here
                print("Button clicked!")
            } label: {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(width: 130, height: 50)
            .background(RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color.green))
            Spacer()
        }
    }
}

#Preview {
    RatingsView(rating: 4)
}
