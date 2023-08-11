//
//  ZoneListView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/1/23.
//

import SwiftUI
import SwiftData

struct ZoneListView: View {
    @Bindable var zone: Zone
    @Binding var selectedClimb: Climb?
    
    var body: some View {
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
                        
                        Button {
                            zone.strip(climb: climb)
                        } label: {
                            Label("Strip", systemImage: "arrow.down.app")
                        }
                        .tint(.purple)
                    case .down:
                        Button {
                            zone.reinstate(climb)
                        } label: {
                            Label("Reinstate", systemImage: "checkmark.gobackward")
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
        }
    }
}

//#Preview {
//    ZoneListView()
//}