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
    var zone: Zone?
    
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
    //TODO: provide difrint sort methods so the view can pick how to sort the data
    static func < (lhs: Climb, rhs: Climb) -> Bool {
        if lhs.grade != rhs.grade {
            return lhs.grade < rhs.grade
        } else if lhs.color != rhs.color {
            return lhs.color?.rawValue ?? "" < rhs.color?.rawValue ?? ""
        } else {
            return lhs.setter < rhs .setter
        }
        
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
