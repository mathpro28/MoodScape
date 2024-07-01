//
//  RatingView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import RealmSwift
import SwiftUI

struct RatingsView: View {
    @State var rating: Int

  var body: some View {
    VStack {
      HStack(spacing: 5) {
        ForEach(1...5, id: \.self) { number in
          Image(systemName: number <= rating ? MIcons.starFilled.rawValue : MIcons.starEmpty.rawValue)
            .foregroundColor(Color.yellow)
            .onTapGesture {
              rating = number
            }
        }
      }
//        Spacer()
        Button {
            guard rating > 0 else { return }
            print("Rating submitted: \(rating)")
        } label: {
            Text("Submit")
                .bold()
                .foregroundColor(.black)
                .padding()
        }
        .frame(width: 130, height: 50)
        .background(RoundedRectangle(cornerRadius: 20)
        .foregroundColor(Color.gray))
        .shadow(radius: 10)
    }
  }
}


#Preview {
    RatingsView(rating: 4)
}
