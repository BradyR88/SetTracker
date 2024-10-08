//
//  NewClimbsModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 10/8/24.
//

import Foundation

struct NewClimbsModel {
    var grade: Int
    var setter: String?
}

extension NewClimbsModel: Comparable {
    static func < (lhs: NewClimbsModel, rhs: NewClimbsModel) -> Bool {
        lhs.grade < rhs.grade
    }
}
extension NewClimbsModel: Hashable {}

extension Array where Element == NewClimbsModel {
    func mapClimbs(gym: Gym, zone: String) -> [Climb] {
        return self.map { newCLimb in
            Climb(
                grade: Grade(vGrade: newCLimb.grade),
                gym: gym,
                zone: zone,
                setter: newCLimb.setter
            )
        }
    }
}
