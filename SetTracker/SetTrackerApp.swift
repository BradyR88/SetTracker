//
//  SetTrackerApp.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/9/23.
//

import SwiftUI
import SwiftData

@main
struct SetTrackerApp: App {
    
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: [Gym.self])
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(modelContainer)
    }
}
