//
//  GradeChartView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/14/23.
//

import SwiftUI
import Charts

struct GradeChartView: View {
    @Environment(ChartsViewModel.self) var vm
    
    var body: some View {
        Chart {
            ForEach(vm.groupings) { barEntry in
                BarMark(
                    x: .value("Grade", barEntry.name),
                    y: .value("Count", barEntry.number)
                )
                .position(by: .value("Scope", "Gym"))
                .zIndex(0)
            }
            
//            if let count = data.zoneCount {
//                BarMark(
//                    x: .value("Grade", data.gradeString),
//                    y: .value("Count", count)
//                )
//                .position(by: .value("Scope", "Zone"))
//                .foregroundStyle(Color.green)
//                .zIndex(0)
//            }
            
//            if let count = data.idealCount {
//                LineMark(
//                    x: .value("Grade", data.gradeString),
//                    y: .value("Count", count)
//                )
//                .foregroundStyle(Color.red)
//                .zIndex(1)
//                
//                PointMark(
//                    x: .value("Grade", data.gradeString),
//                    y: .value("Count", count)
//                )
//                .foregroundStyle(Color.red)
//                .zIndex(2)
//                
//            }
            
        }
        .padding(.horizontal , 20)
        .padding(.vertical)
    }
}

//#Preview {
//    GradeChartView(gradeData: [1:3,2:3,3:2])
//}
