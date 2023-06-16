//
//  Climb.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import Foundation
import SwiftUI

struct Climb: Codable, Identifiable {
    let id: UUID
    
    var seter: String?
    var dateUp: Date?
    var dateDown: Date?
    var style: [Style]
    var grade: Grade
    var color: holdColors?
    
    var isUp: Bool {
        get {
            if dateDown == nil {
                return true
            } else {
                return false
            }
        }
    }
    var daysUp: Int? {
        guard let dateUp = dateUp else { return nil }
        let to = dateDown ?? Date()
        return Calendar.current.dateComponents([.day], from: dateUp, to: to).day ?? 0
    }
    
    init(seter: String? = nil, style: [Style] = [], grade: Int, color: holdColors? = nil) {
        self.id = UUID()
        self.seter = seter
        self.dateUp = Date()
        self.dateDown = nil
        self.style = style
        self.grade = Grade(actual: grade)
        self.color = color
    }
}

extension Climb: Hashable { }

extension Climb {
    enum Style: String, Codable {
        case crimp, sloper, power, dino, endurance, technical, morpho, bored
    }
    
    enum holdColors: Codable {
        case black, blue, purple, green, orange, white, yellow, brown, pink, red
        
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
                Color.pink
            case .red:
                Color.red
            }
        }
    }
}

extension Climb {
    static let examples = [
        Climb(grade: 3),
        Climb(seter: "Brady", style: [.crimp,.technical], grade: 6),
        Climb(seter: "Nate", style: [.power,.sloper,.technical], grade: 8),
        Climb(seter: "Alaxa", style: [.morpho,.technical], grade: 5),
        Climb(seter: "Brady", style: [.morpho,.power], grade: 5)
    ]
}
