//
//  GymSummaryView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/11/23.
//

import SwiftUI
import SwiftData

struct GymSummaryView: View {
    @Bindable var gym: Gym
    
    var body: some View {
        GradeChartView(climbs: gym.allClimbs)
    }
}

//#Preview {
//        GymSummaryView(gym: Gym(name: "test", zones: []))
//}
