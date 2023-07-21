//
//  HelperExtensions.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/8/23.
//

import Foundation

//This extension allows UUID to work with @AppStorage 
extension UUID: RawRepresentable {
    public var rawValue: String {
        self.uuidString
    }

    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        self.init(uuidString: rawValue)
    }
}

extension Dictionary where Key == Int , Value == Int {
    func asGradeData() -> [ChartsDataModel.GradeData] {
        // converts the grade count from a dictionary into an array of GradeData
        var gradeCount = self.map { grade, count in
            return ChartsDataModel.GradeData(grade: grade, gymCount: count, zoneCount: nil)
        }
        // adds in zero values for all of the missing grades
        let maxGrade = self.keys.max() ?? 0
        for i in 0..<maxGrade {
            if !self.keys.contains(i) {
                gradeCount.append(ChartsDataModel.GradeData(grade: i, gymCount: 0, zoneCount: nil))
            }
        }
        
        return gradeCount
    }
    
}
