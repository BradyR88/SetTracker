//
//  Grade.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import Foundation

struct Grade: Comparable {
    var planded: Int?
    var actual: Int?
    
    var grade: Int? {
        get {
            if let actual = actual {
                return actual
            } else {
                return planded
            }
        }
    }
    
    static func < (lhs: Grade, rhs: Grade) -> Bool {
        guard let lhsGrade = lhs.grade else { return false }
        guard let rhsGrade = rhs.grade else { return true }
        
        return lhsGrade < rhsGrade
    }
}

extension Grade {
    init(planded: Int?) {
        self.planded = planded
        self.actual = nil
    }
}
