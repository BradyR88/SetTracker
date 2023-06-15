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
            
            
            List(gym.zones) { zone in
                NavigationLink(value: zone) {
                    HStack {
                        Text(zone.name)
                        Spacer()
                        Text(zone.daysSinceLastSet.description)
                    }
                }
                .onSubmit {
                    print("test")
                }
            }
            
        }
        .navigationDestination(for: Zone.self) { zone in
            ZoneSummaryView(zone: zone)
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        HomeView()
            .modelContainer(previewContainer)
    }
}
