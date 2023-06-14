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
    @Attribute(.unique) let id: UUID
    var name: String
    var zones: [Zone]
    
    var allClimbs: [Climb] {
        get {
            zones.flatMap { $0.climbs }
        }
    }
    
    init(name: String, zones: [Zone]) {
        self.id = UUID()
        self.name = name
        self.zones = zones
    }
}

extension Gym: Identifiable {}

// Provides example data to use in previews
extension Gym {
    static let example = Gym(name: "Alchemy", zones: Zone.examples)
}
