//
//  ChartDataModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/17/23.
//

import Observation
import Foundation

struct ChartsDataModel {
    let gradeCount: [Int : Int]
    let styleCount: [Style : Int]
    
    var isEmpty: Bool {
        gradeCount.isEmpty && styleCount.isEmpty
    }
    
    init(climbs: [Climb]) {
        var gradeCount: [Int : Int] = [:]
        var styleCount: [Style : Int] = [:]
        
        climbs.forEach { climb in
            if let pastCount = gradeCount[climb.grade] {
                gradeCount[climb.grade] = pastCount + 1
            } else {
                gradeCount[climb.grade] = 1
            }
            
            climb.style.forEach { style in
                if let pastCount = styleCount[style] {
                    styleCount[style] = pastCount + 1
                } else {
                    styleCount[style] = 1
                }
            }
        }
        
        // ads in style zero counts so colors lineup of two charts
//        Style.allCases.forEach { style in
//            if styleCount[style] == nil {
//                styleCount[style] = 0
//            }
//        }
        
        self.gradeCount = gradeCount
        self.styleCount = styleCount
    }
}

