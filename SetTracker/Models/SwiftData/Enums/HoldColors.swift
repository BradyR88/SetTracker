//
//  HoldColors.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/17/23.
//

import Foundation
import  SwiftUI

enum HoldColors: String, CaseIterable, Codable, Identifiable {
    case black = "Black", blue = "Blue", purple = "Purple", green = "Green", orange = "Orange", white = "White", yellow = "Yellow", brown = "Brown", pink = "Pink", red = "Red"
    
    var id: Self { return self }
    
    var uiColor: Color {
        switch self {
        case .black:
            Color.black
        case .blue:
            Color.blue
        case .purple:
            Color.purple
        case .green:
            Color.green
        case .orange:
            Color.orange
        case .white:
            Color.white
        case .yellow:
            Color.yellow
        case .brown:
            Color.brown
        case .pink:
            Color(red: 255, green: 0, blue: 127)
        case .red:
            Color.red
        }
    }
}
