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

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Gym.self)
    }
}
