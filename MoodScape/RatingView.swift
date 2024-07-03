//
//  RatingView.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import SwiftUI
import RealmSwift

struct RatingView: View {
    @State private var rating: Int = 0
    @State private var showAlert: Bool = false
    
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
            
            Button(action: saveRating) {
                Text("Submit")
                    .bold()
                    .foregroundColor(.black)
                    .padding()
            }
            .frame(width: 130, height: 50)
            .background(RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color.gray))
            .shadow(radius: 10)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Mood Saved"), message: Text("Your mood has been saved successfully."), dismissButton: .default(Text("OK")))
            }
        }
    }

    func saveRating() {
        guard rating > 0 else { return }

        let realm = try! Realm()
        let today = Calendar.current.startOfDay(for: Date())

        // Check if there are existing moods for today
        let existingMoods = realm.objects(MoodEntry.self).filter("date == %@", today)
        let totalMoodScale: Int = existingMoods.sum(ofProperty: "moodScale")
        let count: Int = existingMoods.count

        try! realm.write {
            // If there are existing moods for today, average the mood scales
            if count > 0 {
                let newMoodScale = (totalMoodScale + rating) / (count + 1)
                for mood in existingMoods {
                    mood.moodScale = newMoodScale
                }
            } else {
                // If no mood for today exists, create a new one
                let newMood = MoodEntry()
                newMood.date = today
                newMood.moodScale = rating
                realm.add(newMood)
            }
        }

        showAlert = true
        print("Rating submitted: \(rating)")
    }
}

#Preview {
    RatingView()
}
