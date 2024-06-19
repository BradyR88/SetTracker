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
    @Relationship(deleteRule: .cascade, inverse: \Climb.gym) var climbs: [Climb]
    var difficultyCurve: DifficultyCurve
    
    init(name: String, difficultyCurve: DifficultyCurve = DifficultyCurve()) {
        self.id = UUID()
        self.name = name
        self.climbs = []
        self.difficultyCurve = difficultyCurve
    }
}
