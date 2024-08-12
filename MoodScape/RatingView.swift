//
//  RatingView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import SwiftUI
import SwiftData

struct RatingView: View {
    @Environment(\.modelContext) private var context
    
    @Binding var rating: Int // Binding to update rating in ContentView
    
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                ForEach(1...5, id: \.self) { number in
                    Text("\(number)")
                        .frame(width: 40, height: 40)
                        .background(number <= rating ? Color.yellow : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .onTapGesture {
                            rating = number // Update the rating
                        }
                }
            }
            .padding(.bottom, 20)
            
            if rating > 0 {
                Button(action: {
                    let newEntry = Register(value: rating, date: .now)
                    context.insert(newEntry)
                    print("Rating submitted: \(rating)")
                }) {
                    Image(systemName: "checkmark")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 130, height: 50)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.gray))
                        .shadow(radius: 10)
                }
            }
        }
        .padding()
        .foregroundColor(.white)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Register.self, configurations: config)

    return RatingView(rating: .constant(0)) // Use .constant for preview
        .modelContainer(container)
}
