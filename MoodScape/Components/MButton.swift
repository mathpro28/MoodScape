//
//  MButton.swift
//  MoodScape
//
//  Created by Santiago Mendoza on 31/8/24.
//

import SwiftUI

struct MButton: View {

    let systemName: String
    let action: () -> ()

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .bold()
                .foregroundColor(.white)
                .padding()
                .frame(width: 130, height: 50)
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.cCoral)
                }
                .shadow(radius: 10)
        }
    }
}

#Preview {
    MButton(systemName: "checkmark") {
        // Do Nothing
    }
}
