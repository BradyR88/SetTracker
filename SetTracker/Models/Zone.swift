//
//  Zone.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import SwiftData
import Foundation

@Model
final class Zone {
    let id: UUID
    var name: String
    @Relationship(.cascade) var climbs: [Climb]
    @Relationship(.cascade) var oldClimbs: [Climb]
    
    var daysSinceLastSet: (description: String, days: Int?) {
        get {
            var days: Int? = nil
            
            guard !climbs.isEmpty else { return ("Empty", nil) }
            
            for climb in climbs {
                if days == nil {
                    days = climb.daysUp
                } else if let daysUp = climb.daysUp {
                    if daysUp > days! {
                        days = daysUp
                    }
                }
            }
            
            if days == nil {
                return ("Unknown",nil)
            } else {
                return ("Last set \(days!) days ago", days)
            }
        }
    }
    
    /// Deletes relevant Climb from Climbs list. Does not go into oldClimbs.
    func delete(_ climb: Climb) {
        climbs.removeAll { _climb in
            climb.id == _climb.id
        }
    }
    
    /// Marks all climbs in a zone as up 
    func settingFinished() {
        climbs.forEach { climb in
            climb.state = .up
        }
    }
    
    /// Add soldClimb back into the Climb list and marks its state as .up
    func reinstate(_ climb: Climb) {
        for (index, oldClimb) in oldClimbs.enumerated() {
            if oldClimb.id == climb.id {
                oldClimb.state = .up
                climbs.append(oldClimb)
                oldClimbs.remove(at: index)
                break
            }
        }
    }
    
    func reset(on date: Date = Date()) {
        climbs.forEach { climb in
            climb.state = .down
        }
        oldClimbs.append(contentsOf: climbs)
        climbs.removeAll()
    }
    
    init(name: String, climb: [Climb] = []) {
        self.id = UUID()
        self.name = name
        self.climbs = climb
    }
    
    enum DisplayMode {
        case currentClimbs, oldClimbs
        
        var toggleButtonText: String {
            switch self {
            case .currentClimbs:
                "Old Climbs"
            case .oldClimbs:
                "Current Climbs"
            }
        }
    }
}

extension Zone: Comparable {
    //TODO: provide multiple sort options, so the view can't decide what type of sort it wants
    static func < (lhs: Zone, rhs: Zone) -> Bool {
        lhs.name < rhs.name
    }
}

extension Zone {
    static let example = Zone(name: "Zone 1", climb: [Climb(grade: 1),Climb(grade: 3)])
    
    static let examples = [
        Zone(name: "Zone 1", climb: [Climb(grade: 1),Climb(grade: 3)]),
        Zone(name: "Zone 2", climb: [Climb(grade: 3),Climb(grade: 3)]),
        Zone(name: "Zone 3", climb: [Climb(grade: 7),Climb(grade: 4)]),
        Zone(name: "Zone 4", climb: [Climb(grade: 1),Climb(grade: 4)])
    ]
}
