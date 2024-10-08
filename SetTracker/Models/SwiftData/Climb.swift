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
    var id: UUID
    var date: Date
    var grade: Grade
    var gym: Gym
    var zone: String
    var setter: String?
    
    init(date: Date = Date(), grade: Grade, gym: Gym, zone: String = "", setter: String? = nil) {
        self.id = UUID()
        self.date = date
        self.grade = grade
        self.gym = gym
        self.zone = zone
        self.setter = setter
    }
}
