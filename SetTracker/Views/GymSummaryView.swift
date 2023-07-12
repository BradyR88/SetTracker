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
            
            
            List(gym.zones.sorted()) { zone in
                NavigationLink(value: zone) {
                    HStack {
                        Text(zone.name)
                        Spacer()
                        Text(zone.daysSinceLastSet.description)
                    }
                }
                .swipeActions {
                    Button {
                        zone.reset()
                    } label: {
                        Label("Reset", systemImage: "checkmark.gobackward")
                    }
                }
            }
        }
        .navigationDestination(for: Zone.self) { zone in
            ZoneSummaryView(zone: zone)
        }
    }
}

//struct Preview_GymSummaryView: PreviewProvider {
//    static var previews: some View {
//        let comfig = ModelConfiguration(inMemory: true)
//        let comtainer = try! ModelContainer(for: Gym.self, comfig)
//        
//        GymSummaryView(gym: Gym.example)
//            .modelContainer(comtainer)
//    }
//}

//#Preview {
//    MainActor.assumeIsolated {
//        HomeView()
//            .modelContainer(previewContainer)
//    }
//}
