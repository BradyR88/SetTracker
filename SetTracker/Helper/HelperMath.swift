//
//  HelperMath.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/24/23.
//

import Foundation

struct HelperMath {
    static let singal = HelperMath()
    
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
