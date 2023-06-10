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
}


extension Climb {
    enum Style: String, Codable {
        case crimp, sloper, power, dino, endurance, technical, morpho, bored
    }
}
