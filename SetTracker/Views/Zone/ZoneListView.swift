//
//  ZoneListView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/1/23.
//

import SwiftUI
import SwiftData

struct ZoneListView: View {
    @Environment(\.modelContext) private var modelContext
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
                            Label("Seting", systemImage: "checkmark.gobackward")
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

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Zone.self, configurations: config)
        
        let example = Zone(name: "Test", climb: [])
        return ZoneListView(zone: example, selectedClimb: .constant(nil))
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
