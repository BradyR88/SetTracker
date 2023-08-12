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
            AllChartsView(data: ChartsDataModel(gym: gym))
            
            List(gym.zones.sorted()) { zone in
                NavigationLink(value: zone) {
                    VStack(alignment: .leading) {
                        Text(zone.name)
                            .bold()
                        Group {
                            Text("Climbs: \(zone.climbs.count)")
                            Text(zone.lastSetDescription)
                        }
                        .font(.subheadline)
                    }
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
//    MainActor.assumeIsolated {
//        GymSummaryView(gym: Gym.example)
//            .modelContainer(previewContainer)
//    }
//    
//}
