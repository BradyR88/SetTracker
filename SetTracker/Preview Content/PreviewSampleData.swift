//
//  PreviewSampleData.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/14/23.
//

import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: Gym.self, ModelConfiguration(inMemory: true)
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
        Gym(name: "test 0", zones: [PreviewExamples.exampleZone]),
        Gym(name: "test 1", zones: []),
        Gym(name: "test 2", zones: []),
        Gym(name: "test 3", zones: []),
        Gym(name: "test 4", zones: []),
        Gym(name: "test 5", zones: []),
        Gym(name: "test 6", zones: []),
    ]
}

struct PreviewExamples {
    static let exampleStyleData = [Style.crimp : 4, Style.sloper : 5, Style.dyno : 0, Style.dyno : 1, Style.power : 3, Style.pinch : 5, Style.endurance : 1]
    static let exampleGradeData = [1 : 4, 2 : 5, 3 : 0, 4 : 1, 5 : 3, 6 : 5, 7 : 1]
    
    static let exampleClimb = Climb(seter: "Brady Roshaw", style: [.crimp,.endurance], grade: 6 ,color: .white)
    static let examplesClimbs = [
        Climb(grade: 3),
        Climb(seter: "Brady", style: [.crimp,.pinch], grade: 6),
        Climb(seter: "Nate", style: [.power,.sloper,], grade: 8),
        Climb(seter: "Alaxa", style: [], grade: 5),
        Climb(seter: "Brady", style: [.dyno,.power], grade: 5)
    ]
    
    static let exampleZone = Zone(name: "Zone 1", climb: [Climb(grade: 1),Climb(grade: 3)])
    static let examplesZones = [
        Zone(name: "Zone 1", climb: [Climb(grade: 1),Climb(grade: 3)]),
        Zone(name: "Zone 2", climb: [Climb(grade: 3),Climb(grade: 3)]),
        Zone(name: "Zone 3", climb: [Climb(grade: 7),Climb(grade: 4)]),
        Zone(name: "Zone 4", climb: [Climb(grade: 1),Climb(grade: 4)])
    ]
    
    static let exampleGym = Gym(name: "Alchemy", zones: [
        Zone(name: "Zone 1", climb: [Climb(grade: 1),Climb(grade: 3)]),
        Zone(name: "Zone 2", climb: [Climb(grade: 3),Climb(grade: 3)])
        ])
}
