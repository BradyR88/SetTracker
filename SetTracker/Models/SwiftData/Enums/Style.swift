//
//  Style.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/17/23.
//

import Foundation

enum Style: String, CaseIterable, Codable, Comparable {
    // this is lemeted to 7 case's because of chart color limatations (endurance was originally also included)
    case crimp = "Crimp", sloper = "Sloper", power = "Power", dyno = "Dyno", pinch = "Pinch", endurance = "Endurance"
    
    static func < (lhs: Style, rhs: Style) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
