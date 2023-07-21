//
//  ChartDataModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/17/23.
//

import Observation
import Foundation

struct ChartsDataModel {
    let gradeCount: [GradeData]
    let styleCount: [Style : Int]
    
    var isEmpty: Bool {
        gradeCount.isEmpty && styleCount.isEmpty
    }
    
    init(climbs: [Climb]) {
        var gradeDictionary: [Int : Int] = [:]
        var styleCount: [Style : Int] = [:]
        
        climbs.forEach { climb in
            //Create new dictionary key with value of 1 on first instance of new grade, and counts up by one, if that grade already exist
            if let pastCount = gradeDictionary[climb.grade] {
                gradeDictionary[climb.grade] = pastCount + 1
            } else {
                gradeDictionary[climb.grade] = 1
            }
            
            // while looping through all the climbs records the number of each style
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
        
        self.gradeCount = gradeDictionary.asGradeData()
        self.styleCount = styleCount
    }
}

extension ChartsDataModel {
    struct GradeData: Comparable, Identifiable {
        let id = UUID()
        
        let grade: String
        let gymCount: Int
        let zoneCount: Int?
        
        static func < (lhs: ChartsDataModel.GradeData, rhs: ChartsDataModel.GradeData) -> Bool {
            lhs.grade < rhs.grade
        }
        
        init(grade: Int, gymCount: Int, zoneCount: Int?) {
            self.grade = "V\(grade)"
            self.gymCount = gymCount
            self.zoneCount = zoneCount
        }
    }
}
