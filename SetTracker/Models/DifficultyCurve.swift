//
//  DifficultyCurve.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/24/23.
//

import Foundation
import SwiftData

@Model
class DifficultyCurve {
    let goalCount: [Int : Int]
    
    var total: Int {
        var total: Int = 0
        goalCount.values.forEach { total += $0 }
        return total
    }
    
    // this results in some rounding, that might mean everything does not add up to 100
    var goalPersent: [Int : Int] {
        goalCount.mapValues { i in
            i / total * 100
        }
    }
    
    init(goalCount: [Int : Int]) {
        self.goalCount = goalCount
    }
}
