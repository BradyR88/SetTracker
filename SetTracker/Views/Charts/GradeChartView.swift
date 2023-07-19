//
//  GradeChartView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/14/23.
//

import SwiftUI
import Charts

struct GradeChartView: View {
    let gradeData: [Int : Int]
    
    var body: some View {
        Chart {
            ForEach(gradeData.sorted(by: >), id: \.key) { grade, count in
                BarMark(x: .value("Grade", grade),
                        y: .value("Count", count))
            }
            
        }
        .padding(.horizontal , 20)
        .padding(.vertical)
    }
}

//#Preview {
//    GradeChartView(climbs: Climb.example)
//}
