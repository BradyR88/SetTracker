//
//  ZoneSummaryView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/14/23.
//

import SwiftUI
import SwiftData

struct ZoneSummaryView: View {
    @Binding var zone: Zone
    
//    @State private var sheetClimb: Climb? = nil
    
    var body: some View {
        VStack {
            GradeChartView(climbs: zone.climbs)
            
            List {
                ForEach($zone.climbs) { $climb in
                    HStack {
                        NavigationLink {
                            ClimbEditSheet(climb: $climb)
                        } label: {
                            Text("\(climb.grade.description)")
                        }
                    }
                }
                
                Button("Add Climb") {
                    zone.climbs.append(Climb(grade: 1))
                }
            }
            
        }
        .navigationTitle(zone.name)
//        .sheet(item: $sheetClimb) { _ in
//            ClimbEditSheet(climb: $sheetClimb)
//                .presentationDetents([.fraction(0.25)])
//        }
    }
}

//#Preview {
//    NavigationStack {
//        ZoneSummaryView(zone: .constant(Zone.example))
//    }
//    
//}
