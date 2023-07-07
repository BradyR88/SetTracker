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
        VStack {
            GradeChartView(climbs: gym.allClimbs)
                .frame(height: 300)
            
            
            List(gym.zones) { zone in
                NavigationLink(value: zone) {
                    HStack {
                        Text(zone.name)
                        Spacer()
                        Text(zone.daysSinceLastSet.description)
                    }
                }
            }
            
        }
        .navigationDestination(for: Zone.self) { zone in
            ZoneSummaryView(zone: .constant(Zone.examples[0]))
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        HomeView()
            .modelContainer(previewContainer)
    }
}
