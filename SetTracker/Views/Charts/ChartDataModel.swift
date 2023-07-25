//
//  ChartDataModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/17/23.
//


import Foundation

struct ChartsDataModel {
    var gradeCount: [GradeData] = []
    var styleCount: [Style : Int] = [:]
    
    var isEmpty: Bool {
        gradeCount.isEmpty && styleCount.isEmpty
    }
    
    mutating func showGym(_ gym: Gym) {
        let climbs = gym.climbs
        
        let (gradeDictionary, styleCount) = getDataDictionary(from: climbs)
        
        self.gradeCount = asGradeData(gradeDictionary)
        mergeIn(difficultyCurve: gym.difficultyCurve)
        
        self.styleCount = styleCount
    }
    
    mutating func showZone(_ zone: Zone) {
        if let gym = zone.gym {
            showGym(gym)
        }
        
        let data = getDataDictionary(from: zone.climbs)
        
        mergeIn(zoneData: data)
    }
    
    /// Convert an [Int:Int] dictionary into a array of GradeData so that the data can be more easily parsed by a char.
    private func asGradeData(_ gradeDictionary: [Int : Int]) -> [GradeData] {
        // converts the grade count from a dictionary into an array of GradeData
        var gradeCount = gradeDictionary.map { grade, count in
            return GradeData(grade: grade, gymCount: count)
        }
        // adds in zero values for all of the missing grades
        let maxGrade = gradeDictionary.keys.max() ?? 0
        for i in 0..<maxGrade {
            if !gradeDictionary.keys.contains(i) {
                gradeCount.append(GradeData(grade: i, gymCount: 0))
            }
        }
        return gradeCount
    }
    
    /// Iterate through all of the climbs, counting out the number of each grade and each style and returns that information in the form of two dictionary's.
    private func getDataDictionary(from climbs: [Climb]) -> (gradeDictionary: [Int : Int], styleCount: [Style : Int]) {
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
        
        return (gradeDictionary,styleCount)
    }
    
    /**
     Add zone data in to allow charts to display extra zone information when necessary
     
     This only works when the zone is part of the gym errors can occur if the zone contains climbs that are not also in the gym.
     */
    private mutating func mergeIn(zoneData data: (gradeDictionary: [Int : Int], styleCount: [Style : Int])) {
        for (index,gradeData) in gradeCount.enumerated() {
            if let zoneCount = data.gradeDictionary[gradeData.grade] {
                gradeCount[index].zoneCount = zoneCount
            }
        }
        
        self.styleCount = data.styleCount
    }
    
    mutating func mergeIn(difficultyCurve curve: DifficultyCurve) {
        for (index,gradeData) in gradeCount.enumerated() {
            if let idealCount = curve.goalCount[gradeData.grade] {
                gradeCount[index].idealCount = idealCount
            }
        }
    }
    
    init(gym: Gym) {
        showGym(gym)
    }
    
    init(zone: Zone) {
        showZone(zone)
    }
}

extension ChartsDataModel {
    struct GradeData: Comparable, Identifiable {
        let id = UUID()
        
        let grade: Int
        let gymCount: Int
        var zoneCount: Int?
        var idealCount: Int?
        
        var gradeString: String { "V\(grade)"}
        
        static func < (lhs: GradeData, rhs: GradeData) -> Bool {
            lhs.grade < rhs.grade
        }
        
        init(grade: Int, gymCount: Int, zoneCount: Int? = nil, idealCount: Int? = nil) {
            self.grade = grade
            self.gymCount = gymCount
            self.zoneCount = zoneCount
            self.idealCount = idealCount
        }
    }
}
