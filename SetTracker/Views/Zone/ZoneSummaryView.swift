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
    
    var body: some View {
        VStack {
            AllChartsView(data: ChartsDataModel(zone: zone))
            
            if selectedClimb == nil {
                List {
                    ForEach(zone.climbs.sorted()) { climb in
                        Button {
                            withAnimation {
                                selectedClimb = climb
                            }
                        } label: {
                            ClimbDescriptionView(climb: climb)
                        }
                        .swipeActions {
                            switch climb.state {
                            case .inProgress:
                                Button {
                                    climb.state = .up
                                } label: {
                                    Label("Done Seting", systemImage: "checkmark")
                                }
                                .tint(.green)
                            case .up:
                                Button {
                                    climb.state = .inProgress
                                } label: {
                                    Label("Done Seting", systemImage: "checkmark.gobackward")
                                }
                                .tint(.orange)
                            case .down:
                                Button {
                                    zone.reinstate(climb)
                                } label: {
                                    Label("Done Seting", systemImage: "checkmark.gobackward")
                                }
                                .tint(.teal)
                            }
                            
                            
                            
                            Button(role: .destructive) {
                                zone.delete(climb)
                            } label: {
                                Label(" delete", systemImage: "trash")
                            }
                        }
                    }
                    
                    Section {
                        Button("Add Climb") {
                            zone.climbs.append(Climb(grade: 4))
                        }
                    }
                }
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
                    
                    Button("Done Seting") {
                        zone.setComplete()
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .alert("Reset all Climbs", isPresented: $showingAlert, actions: {
            Button(role: .destructive) {
                zone.reset()
            } label: {
                Text("OK")
            }
            
            Button {
                // do nothing
            } label: {
                Text("Cancel")
            }

        }, message: {
            Text("This will mark all climbs as striped and remove them from the zone.")
        })
    }
}

//#Preview {
//    NavigationStack {
//        ZoneSummaryView(zone: .constant(Zone.example))
//    }
//    
//}
