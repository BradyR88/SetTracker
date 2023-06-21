//
//  ZoneSummaryView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/14/23.
//

import SwiftUI
import SwiftData

struct ZoneSummaryView: View {
    var zone: Zone
    
    @State private var showingSheat = false
    
    var body: some View {
        VStack {
            GradeChartView(climbs: zone.climbs)
            
            List(zone.climbs) { climb in
                HStack {
                    Button(climb.grade.description) {
                        showingSheat = true
                    }
                }
            }
            
        }
        .navigationTitle(zone.name)
        .sheet(isPresented: $showingSheat, content: {
            Text("test")
        })
    }
}

#Preview {
    NavigationStack {
        ZoneSummaryView(zone: Zone.examples.first!)
    }
    
}
