//
//  GymSummaryView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/11/23.
//

import SwiftUI
import SwiftData

struct GymSummaryView: View {
    var gym: Gym
    
    var body: some View {
        VStack {
            GradeChartView(climbs: gym.allClimbs)
                .frame(height: 300)
            
            ScrollView {
                ForEach(gym.zones) { zone in
                    Text(zone.name)
                }
            }
        }
    }
}

//#Preview {
//        GymSummaryView(gym: Gym(name: "test", zones: []))
//}
