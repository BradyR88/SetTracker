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
                    ForEach(zone.climbs) { climb in
                        HStack {
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
                    }
                    
                    Button("Add Climb") {
                        zone.climbs.append(Climb(grade: 4))
                    }
                }
            } else {
                ClimbEditSheet(climb: selectedClimb!, selectedClimb: $selectedClimb)
            }
        }
        .navigationTitle(zone.name)
    }
}

//#Preview {
//    NavigationStack {
//        ZoneSummaryView(zone: .constant(Zone.example))
//    }
//    
//}
