//
//  DifficultyCurve.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/24/23.
//

import Foundation
import SwiftData

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
    
    init() {
        self.goalCount = [
            0 : 5,
            1 : 6,
            2 : 7,
            3 : 8,
            4 : 9,
            5 : 8,
            6 : 6,
            7 : 5,
            8 : 4,
            9 : 3,
            10 : 2,
            11 : 1
        ]
    }
}
