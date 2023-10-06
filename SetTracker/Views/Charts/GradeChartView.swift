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
            ForEach(vm.difficultyCurve ?? []) { barEntry in
                LineMark(
                    x: .value("Grade", barEntry.name),
                    y: .value("Count", barEntry.number)
                )
                .foregroundStyle(Color.red)
                .zIndex(1)
                
                PointMark(
                    x: .value("Grade", barEntry.name),
                    y: .value("Count", barEntry.name)
                )
                .foregroundStyle(Color.red)
                .zIndex(1)
            }
            
            ForEach(vm.allGroupings) { barEntry in
                BarMark(
                    x: .value("Grade", barEntry.name),
                    y: .value("Count", barEntry.number)
                )
                .position(by: .value("Scope", "Gym"))
                .zIndex(0)
            }
            
            ForEach(vm.zoneGroupings) { barEntry in
                BarMark(
                    x: .value("Grade", barEntry.name),
                    y: .value("Count", barEntry.number)
                )
                .position(by: .value("Scope", "Zone"))
                .foregroundStyle(Color.green)
                .zIndex(0)
            }
        }
        .padding(.horizontal , 20)
        .padding(.vertical)
    }
}

//#Preview {
//    GradeChartView(gradeData: [1:3,2:3,3:2])
//}
