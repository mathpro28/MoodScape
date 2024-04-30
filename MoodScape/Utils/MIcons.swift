//
//  MIcons.swift
//  MoodScape
//
//  Created by Mateo Mercado Maguiña on 29/4/24.
//

import Foundation

enum MIcons: String {
    case starFilled = "star.fill"
    case starEmpty = "star"
    case box = "figure.boxing"
    
    var systemImage: String {
        self.rawValue
    }
}
