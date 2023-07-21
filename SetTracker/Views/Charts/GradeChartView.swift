//
//  GradeChartView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/14/23.
//

import SwiftUI
import Charts

struct GradeChartView: View {
    let gradeData: [ChartsDataModel.GradeData]
    
    var body: some View {
        Chart {
            ForEach(gradeData.sorted()) { data in
                BarMark(
                    x: .value("Grade", data.gradeString),
                    y: .value("Count", data.gymCount)
                )
                .position(by: .value("Scope", "Gym"))
                
                if let count = data.zoneCount {
                    BarMark(
                        x: .value("Grade", data.gradeString),
                        y: .value("Count", count)
                    )
                    .position(by: .value("Scope", "Zone"))
                    .foregroundStyle(Color.green)
                }
            }
            
        }
        .padding(.horizontal , 20)
        .padding(.vertical)
    }
}

//#Preview {
//    GradeChartView(gradeData: PreviewExamples.exampleGradeData)
//}
