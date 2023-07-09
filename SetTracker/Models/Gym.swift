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
    @Relationship(.cascade) var zones: [Zone]
    
    var allClimbs: [Climb] {
        get {
            zones.flatMap { $0.currentClimbs }
        }
    }
    
    init(name: String, zones: [Zone]) {
        self.id = UUID()
        self.name = name
        self.zones = zones
    }
}

// Provides example data to use in previews
extension Gym {
    static let example = Gym(name: "Alchemy", zones: Zone.examples)
}
