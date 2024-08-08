//
//  MoodsView.swift
//  MoodScape
//
//  Created by mateo mercado on 7/8/24.
//

import SwiftUI

struct MoodsView: View {
    
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            Group {
                switch rating {
                case 1:
                    Image("mood_1")
                        .resizable()
                case 2:
                    Image("mood_2")
                        .resizable()
                case 3:
                    Image("mood_3")
                        .resizable()
                case 4:
                    Image("mood_4")
                        .resizable()
                        .mask {
                            Rectangle().offset(y:2)
                        }
                case 5:
                    Image("mood_5")
                        .resizable()
                default:
                    Image("mood_error")
                        .resizable()
                }
            }
        }
        .frame(width: 150, height: 150)
        .foregroundColor(.white) // Set text color to white
        .preferredColorScheme(.dark)
    }
}

struct MoodsView_Previews: PreviewProvider {
    static var previews: some View {
        MoodsViewContainer()
    }

    struct MoodsViewContainer: View {
        @State private var rating = 3

        var body: some View {
            MoodsView(rating: $rating)
        }
    }
}

