//
//  Zone.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import Foundation

struct Zone: Codable {
    let id: UUID
    
    var name: String
    var climbs: [Climb]
    
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
    
    init(name: String, climb: [Climb] = []) {
        self.id = UUID()
        self.name = name
        self.climbs = climb
    }
}

extension Zone: Identifiable { }

extension Zone: Hashable { }

extension Zone {
    static let examples = [
        Zone(name: "Zone 1", climb: [Climb(grade: 1),Climb(grade: 3)]),
        Zone(name: "Zone 2", climb: [Climb(grade: 3),Climb(grade: 3)]),
        Zone(name: "Zone 3", climb: [Climb(grade: 7),Climb(grade: 4)]),
        Zone(name: "Zone 4", climb: [Climb(grade: 1),Climb(grade: 4)])
    ]
}
