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
    var goalCount: [Int : Int]
    
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
    
    func goalNormalised(to num: Int) -> [Int : Double] {
        let offset = Double(num) / Double(total)
        return goalCount.mapValues { value in return Double(value) * offset }
    }
    
    func onIncrement(of grade: Int) {
        goalCount[grade]? += 1
    }
    
    func onDecrement(of grade: Int) {
        goalCount[grade]? -= 1
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
    
    init(center: Int, hight: Int, skew: Int) {
        var value: [Int:Int] = [center : hight]
        var headOffset: Int = 1
        
        var head: Int { center + headOffset }
        
        while head <= 11 {
            value[head] = Int(Double(hight) * (-0.1*Double(abs(headOffset)) + 1))
            headOffset += 1
        }
        
        headOffset = -1
        
        while head >= 0 {
            value[head] = Int(Double(hight) * (-0.1*Double(abs(headOffset)) + 1))
            headOffset -= 1
        }
        
        self.goalCount = value
    }
}
