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
            container.mainContext.insert(object: gym)
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()

struct SampleGyms {
    static var contents: [Gym] = [
        Gym(name: "test 0", zones: []),
        Gym(name: "test 1", zones: []),
        Gym(name: "test 2", zones: []),
        Gym(name: "test 3", zones: []),
        Gym(name: "test 4", zones: []),
        Gym(name: "test 5", zones: []),
        Gym(name: "test 6", zones: []),
    ]
}
