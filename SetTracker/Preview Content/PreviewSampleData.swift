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
        Gym(name: "test 0", zones: Zone.examples),
        Gym(name: "test 1", zones: []),
        Gym(name: "test 2", zones: []),
        Gym(name: "test 3", zones: []),
        Gym(name: "test 4", zones: []),
        Gym(name: "test 5", zones: []),
        Gym(name: "test 6", zones: []),
    ]
}

struct PreviewExamples {
    static let exampleStyleData = [Style.crimp : 4, Style.sloper : 5, Style.bored : 0, Style.dino : 1, Style.power : 3, Style.technical : 5, Style.morpho : 1]
    static let exampleGradeData = [1 : 4, 2 : 5, 3 : 0, 4 : 1, 5 : 3, 6 : 5, 7 : 1]
}
