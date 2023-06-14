//
//  Zone.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import Foundation

struct Zone: Codable {
    let id: UUID
    
    var name: String?
    var climb: [Climb]
    
    init(name: String? = nil, climb: [Climb]) {
        self.id = UUID()
        self.name = name
        self.climb = climb
    }
}

extension Zone {
    static let examples = [
        Zone(name: "Zone 1", climb: [Climb(grade: 1),Climb(grade: 3)]),
        Zone(name: "Zone 2", climb: [Climb(grade: 3),Climb(grade: 3)]),
        Zone(name: "Zone 3", climb: [Climb(grade: 7),Climb(grade: 4)]),
        Zone(name: "Zone 4", climb: [Climb(grade: 1),Climb(grade: 4)])
    ]
}
