//
//  Grade.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import Foundation

struct Grade {
    let gradeType: GradeTypes
    let grade: String
    let vEquivalent: Double
    
    init(vGrade: Int) {
        self.gradeType = .v
        self.grade = String("V\(vGrade)")
        self.vEquivalent = Double(vGrade)
    }
}

extension Grade: Codable {}
extension Grade: Comparable {
    static func < (lhs: Grade, rhs: Grade) -> Bool {
        lhs.vEquivalent < rhs.vEquivalent
    }
}
