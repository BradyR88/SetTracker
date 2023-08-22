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
    
    init(center: Int, hight: Int, leftSkew: Double, rightSkew: Double) {
        var value: [Int:Int] = [center : hight]
        let standardDeviation = 3.0
        let maxValue = 12
        let minValue = 1
        
        for grade in minValue..<maxValue {
            value[grade] = normalDistributionY(x: Double(grade), height: Double(hight), center: Double(center), standardDeviation: standardDeviation)
        }
        
        for grade in center..<maxValue {
            guard let oldValue = value[grade] else { return }
            value[grade] = Int(compressIntoNewRange(input: Double(oldValue), max: Double(hight), min: 0, newMin: rightSkew))
        }
        
        for grade in minValue..<center {
            guard let oldValue = value[grade] else { return }
            value[grade] = Int(compressIntoNewRange(input: Double(oldValue), max: Double(hight), min: 0, newMin: leftSkew))
        }
        
        self.goalCount = value
        
        func normalDistributionY(x: Double, height: Double, center: Double, standardDeviation: Double) -> Int {
            let exponent = -pow((x - center), 2) / (2 * pow(standardDeviation, 2))
            let coefficient = height
            return Int(coefficient * exp(exponent))
        }
        
        func compressIntoNewRange(input: Double, max: Double, min: Double, newMin: Double) -> Double {
            let startRange = max - min
            let offOfMax = max - input
            let ratio = offOfMax / startRange
            let newRange = max - newMin
            return max - (ratio * newRange)
        }
    }
}
