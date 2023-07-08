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
    
    @State private var selectedClimb: Climb? = nil
    
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
                                Text("\(climb.grade.description)")
                            }
                        }
                    }
                    
                    Button("Add Climb") {
                        zone.climbs.append(Climb(grade: 1))
                    }
                }
            } else {
                ClimbEditSheet(climb: selectedClimb!)
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
