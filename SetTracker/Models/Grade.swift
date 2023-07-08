//
//  Grade.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import Foundation

struct Grade: Codable {
    var planded: Int
    var actual: Int?
    
    var grade: Int {
        get {
            if let actual = actual {
                return actual
            } else {
                return planded
            }
        }
    }
}

extension Grade: Comparable {
    static func < (lhs: Grade, rhs: Grade) -> Bool {
//        guard let lhsGrade = lhs.grade else { return true }
//        guard let rhsGrade = rhs.grade else { return true }
        
        return lhs.grade < rhs.grade
    }
}

extension Grade: CustomStringConvertible {
    var description: String {
        get {
            return "V\(grade)"
            
//            if let grade = grade {
//                return "V\(grade)"
//            } else {
//                return "No Grade"
//            }
        }
    }
}

extension Grade: Hashable { }
