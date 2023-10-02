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
                .zIndex(0)
                
                if let count = data.zoneCount {
                    BarMark(
                        x: .value("Grade", data.gradeString),
                        y: .value("Count", count)
                    )
                    .position(by: .value("Scope", "Zone"))
                    .foregroundStyle(Color.green)
                    .zIndex(0)
                }
                
                if let count = data.idealCount {
                    LineMark(
                        x: .value("Grade", data.gradeString),
                        y: .value("Count", count)
                    )
                    .foregroundStyle(Color.red)
                    .zIndex(1)
                    
                    PointMark(
                        x: .value("Grade", data.gradeString),
                        y: .value("Count", count)
                    )
                    .foregroundStyle(Color.red)
                    .zIndex(2)
                    
                }
            }
            
        }
        .padding(.horizontal , 20)
        .padding(.vertical)
    }
}

//#Preview {
//    GradeChartView(gradeData: [1:3,2:3,3:2])
//}
