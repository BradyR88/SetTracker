//
//  Climb.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import Foundation


struct Climb: Codable, Identifiable {
    let id: UUID
    
    var seter: String?
    var dateUp: Date?
    var dateDown: Date?
    var style: [Style]
    var grade: Grade
    
    var isUp: Bool {
        get {
            if dateDown == nil {
                return true
            } else {
                return false
            }
        }
    }
    var daysUp: Int {
        guard let dateUp = dateUp else { return 0 }
        let to = dateDown ?? Date()
        return Calendar.current.dateComponents([.day], from: dateUp, to: to).day ?? 0
    }
    
    init(seter: String? = nil, style: [Style] = [], grade: Int) {
        self.id = UUID()
        self.seter = seter
        self.dateUp = Date()
        self.dateDown = nil
        self.style = style
        self.grade = Grade(actual: grade)
    }
}

extension Climb: Hashable { }

extension Climb {
    enum Style: String, Codable {
        case crimp, sloper, power, dino, endurance, technical, morpho, bored
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
