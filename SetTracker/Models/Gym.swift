//
//  Gym.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import Foundation
import SwiftData

@Model
final class Gym {
    let id: UUID
    var name: String
    @Relationship(deleteRule: .cascade) var zones: [Zone]
    var difficultyCurve: DifficultyCurve
    
    var climbs: [Climb] {
        get {
            zones.flatMap { $0.climbs }
        }
    }
    
    init(name: String, zones: [Zone], difficultyCurve: DifficultyCurve = DifficultyCurve()) {
        self.id = UUID()
        self.name = name
        self.zones = zones
        self.difficultyCurve = difficultyCurve
    }
}
