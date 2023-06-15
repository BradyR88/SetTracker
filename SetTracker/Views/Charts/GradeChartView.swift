//
//  GradeChartView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/14/23.
//

import SwiftUI
import Charts

struct GradeChartView: View {
    let climbs: [Climb]
    
    var body: some View {
        if climbs.isEmpty {
            ContentUnavailableView("No Climbs", systemImage: "chart.bar", description: nil)
        } else {
            Chart {
                ForEach(climbs, id: \.self) { climb in
                    BarMark(x: .value("Grade", climb.grade.description),
                            y: .value("Count", 1))
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    GradeChartView(climbs: Climb.examples)
}
