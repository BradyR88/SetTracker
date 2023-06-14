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
        Chart {
            ForEach(climbs, id: \.self) { climb in
                BarMark(x: .value("Grade", climb.grade.description),
                        y: .value("Count", 1))
            }
            
        }
        .frame(width: 300, height: 300)
    }
}

#Preview {
    GradeChartView(climbs: Climb.examples)
}
