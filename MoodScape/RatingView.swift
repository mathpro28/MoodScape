//
//  RatingView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import SwiftUI

struct RatingsView: View {
    var rating:Int
    var body: some View {
        HStack {
            ForEach(1...6,id:\.self){ circle in
                Image (systemName: (circle <= rating) ?
                       "star.fill" : "star")
            }
        }
    }
}

#Preview {
    RatingsView(rating: 4)
}
