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
    
    var body: some View {
        VStack {
            GradeChartView(climbs: zone.climbs)
            
            if selectedClimb == nil {
                List {
                    ForEach(zone.climbs.sorted()) { climb in
                        Button {
                            withAnimation {
                                selectedClimb = climb
                            }
                        } label: {
                            HStack {
                                Text(climb.description)
                                Spacer()
                                if let daysUp = climb.daysUp {
                                    Text("\(daysUp)")
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                    
                    if zone.displaymode == .currentClimbs {
                        Section {
                            Button("Add Climb") {
                                zone.currentClimbs.append(Climb(grade: 4))
                            }
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
                    Button(zone.displaymode.toggleButtonText) {
                        zone.toggleDisplayMode()
                    }
                    
                    if zone.displaymode == .currentClimbs {
                        Button("Reset") {
                            zone.reset()
                        }
                        
                        Button("Done Seting") {
                            //TODO: lock the edit
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        //TODO: look in to a way to efficiently do the delete without having to resort the entire list every single time
        zone.currentClimbs.sort()
        zone.currentClimbs.remove(atOffsets: offsets)
    }
}

//#Preview {
//    NavigationStack {
//        ZoneSummaryView(zone: .constant(Zone.example))
//    }
//    
//}
