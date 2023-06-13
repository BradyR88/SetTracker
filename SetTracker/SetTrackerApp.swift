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
            GymPickerView()
        }
        .modelContainer(for: Gym.self)
    }
}
