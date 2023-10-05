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
            AllChartsView(climbs: gym.climbs)
            
            List(gym.zones.sorted()) { zone in
                NavigationLink(value: zone) {
                    ZoneBarView(zone: zone)
                }
                .swipeActions {
                    Button {
                        zone.reset()
                    } label: {
                        Label("Reset", systemImage: "arrow.down.app")
                    }
                    .tint(.purple)
                }
            }
        }
        .navigationDestination(for: Zone.self) { zone in
            ZoneSummaryView(zone: zone)
        }
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Gym.self, configurations: config)
//        
//        let example = Gym(name: "Test", zones: [])
//        return GymSummaryView(gym: example)
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create model container.")
//    }
//}
