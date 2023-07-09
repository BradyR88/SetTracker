//
//  Climb.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import SwiftData
import Foundation
import SwiftUI

@Model
final class Climb {
    let id: UUID
    
    private var _seter: String?
    var dateUp: Date
    var dateDown: Date?
    var grade: Int
    
    //var style: [Style]
    //var color: HoldColors?
    
    var seter: String {
        get {
            return _seter ?? ""
        }
        set {
            if newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self._seter = nil
            } else {
                self._seter = newValue
            }
        }
    }
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
        let to = dateDown ?? Date()
        return Calendar.current.dateComponents([.day], from: dateUp, to: to).day ?? 0
    }
    
    var description: String {
        let grade = "V\(grade)"
        if let seter = _seter {
            return "\(grade) - \(seter)"
        } else {
            return grade
        }
    }
    
    init(seter: String? = nil, style: [Style] = [], grade: Int, color: HoldColors? = nil) {
        self.id = UUID()
        self._seter = seter
        self.dateUp = Date()
        self.dateDown = nil
        //self.style = style
        self.grade = grade
        //self.color = color
    }
}

extension Climb {
    static let example = Climb(seter: "Brady Roshaw", style: [.crimp,.morpho], grade: 6)
    
    static let examples = [
        Climb(grade: 3),
        Climb(seter: "Brady", style: [.crimp,.technical], grade: 6),
        Climb(seter: "Nate", style: [.power,.sloper,.technical], grade: 8),
        Climb(seter: "Alaxa", style: [.morpho,.technical], grade: 5),
        Climb(seter: "Brady", style: [.morpho,.power], grade: 5)
    ]
}

extension Climb: Comparable {
    //TODO: sort by grage and thin the something somethig else if the grades are the same
    //TODO: provide difrint sort methods so the view can pick how to sort the data
    static func < (lhs: Climb, rhs: Climb) -> Bool {
        lhs.grade < rhs.grade
    }
}

enum Style: String, Codable {
    case crimp, sloper, power, dino, endurance, technical, morpho, bored
}

enum HoldColors: Codable {
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
