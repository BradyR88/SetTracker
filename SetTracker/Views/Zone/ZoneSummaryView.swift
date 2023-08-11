//
//  ZoneSummaryView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/14/23.
//

import SwiftUI
import SwiftData

struct ZoneSummaryView: View {
    @Bindable var zone: Zone
    
    @State private var selectedClimb: Climb?
    @State private var showingAlert = false
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            AllChartsView(data: ChartsDataModel(zone: zone))
            
            if selectedClimb == nil {
                ZoneListView(zone: zone, selectedClimb: $selectedClimb)
            } else {
                ClimbEditSheet(climb: selectedClimb!) { selectedClimb = nil }
            }
        }
        .navigationTitle(zone.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("Reset", role: .destructive) {
                        showingAlert = true
                    }
                    
                    Button("Last Set") {
                        showingSheet = true
                    }
                    
                    Button("Done Seting") {
                        zone.setComplete()
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button {
                    let newClimb = Climb(grade: 4)
                    zone.climbs.append(newClimb)
                    selectedClimb = newClimb
                } label: {
                    Label("Add Climb", systemImage: "plus.circle")
                }

            }
        }
        .alert("Reset all Climbs", isPresented: $showingAlert, actions: {
            Button(role: .destructive) {
                zone.reset()
            } label: {
                Text("OK")
            }

        }, message: {
            Text("This will mark all climbs as striped and remove them from the zone.")
        })
        .sheet(isPresented: $showingSheet) {
            DateEditSheet(zone: zone)
                .presentationDetents([.fraction(0.66)])
        }
    }
}

//#Preview {
//    NavigationStack {
//        ZoneSummaryView(zone: .constant(Zone.example))
//    }
//    
//}
