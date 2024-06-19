//
//  PreviewSampleData.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/14/23.
//

import Foundation
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: Gym.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        for gym in SampleGyms.contents {
            container.mainContext.insert(gym)
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()

struct SampleGyms {
    static var contents: [Gym] = [
        Gym(name: "test 0"),
        Gym(name: "test 1"),
        Gym(name: "test 2"),
        Gym(name: "test 3"),
        Gym(name: "test 4"),
        Gym(name: "test 5"),
        Gym(name: "test 6"),
    ]
}

struct PreviewExamples {
    static let exampleStyleData = [Style.crimp : 4, Style.sloper : 5, Style.dyno : 0, Style.dyno : 1, Style.power : 3, Style.pinch : 5, Style.endurance : 1]
    static let exampleGradeData = [1 : 4, 2 : 5, 3 : 0, 4 : 1, 5 : 3, 6 : 5, 7 : 1]
    
    static let exampleClimb = Climb(date: Date(timeIntervalSince1970: TimeInterval(123456)), grade: Grade(vGrade: 5), gym: exampleGym)
    static let examplesClimbs = [
        Climb(grade: Grade(vGrade: 1), gym: exampleGym),
        Climb(grade: Grade(vGrade: 2), gym: exampleGym),
        Climb(grade: Grade(vGrade: 3), gym: exampleGym),
        Climb(grade: Grade(vGrade: 4), gym: exampleGym),
        Climb(grade: Grade(vGrade: 17), gym: exampleGym)
    ]
    
    static let exampleGym = Gym(name: "test 1")
}
