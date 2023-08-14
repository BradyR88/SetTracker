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
    
    private var _setter: String?
    private(set) var dateUp: Date?
    private(set) var dateDown: Date?
    var grade: Int
    var style: [Style]
    var color: HoldColors?
    
    var setter: String {
        get {
            return _setter ?? ""
        }
        set {
            if newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self._setter = nil
            } else {
                self._setter = newValue
            }
        }
    }
    
    var safeDateUp: Date {
        get {
            dateUp ?? Date()
        }
        set {
            dateUp = newValue
        }
    }
    
    /// Record of whether or not the Climb is being set up for general use or has been torn down. Changing the variable automatically sets the dateUp and dateDown.
    var state: State {
        get {
            if dateUp == nil {
                return .inProgress
            } else if dateUp != nil && dateDown == nil {
                return .up
            } else {
                return .down
            }
        }
        set {
            switch newValue {
            case .inProgress:
                dateUp = nil
                dateDown = nil
            case .up:
                dateUp = Date()
                dateDown = nil
            case .down:
                if dateUp == nil {
                    dateUp = Date()
                }
                dateDown = Date()
            }
        }
    }
    
    init(seter: String? = nil, style: [Style] = [], grade: Int, color: HoldColors? = nil) {
        self.id = UUID()
        self._setter = seter
        self.dateUp = nil
        self.dateDown = nil
        self.grade = grade
        self.style = style
        self.color = color
    }
}

extension Climb: Comparable {
    //TODO: sort by grage and thin the something somethig else if the grades are the same
    //TODO: provide difrint sort methods so the view can pick how to sort the data
    static func < (lhs: Climb, rhs: Climb) -> Bool {
        lhs.grade < rhs.grade
    }
}

extension Climb: TimeUpDating {
    var daysUp: Int? {
        let to = dateDown ?? Date()
        guard let dateUp = dateUp else { return nil }
        return Calendar.current.dateComponents([.day], from: dateUp, to: to).day ?? 0
    }
}

extension Climb {
    enum State {
        case inProgress, up, down
    }
}

enum Style: String, CaseIterable, Codable, Comparable {
    // this is lemeted to 7 case's because of chart color limatations (endurance was originally also included)
    case crimp = "Crimp", sloper = "Sloper", power = "Power", dyno = "Dyno", pinch = "Pinch", endurance = "Endurance"
    
    static func < (lhs: Style, rhs: Style) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

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
