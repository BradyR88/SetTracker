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
        .chartForegroundStyleScale(["Revenue": Color.green, "Visits": Color.purple])
        .chartLegend(.visible)
        .chartLegend(position: .bottom) {
            HStack(spacing: 3) {
                BasicChartSymbolShape.circle.foregroundStyle(Color.blue).frame(width: 8, height: 8)
                Text("Gym")
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .padding(.trailing, 3)
                if vm.hasZoneData {
                    BasicChartSymbolShape.circle.foregroundStyle(Color.green).frame(width: 8, height: 8)
                    Text("Zone")
                        .foregroundStyle(.gray)
                        .font(.caption)
                        .padding(.trailing, 3)
                }
                BasicChartSymbolShape.circle.foregroundStyle(Color.red).frame(width: 8, height: 8)
                Text("Target")
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .padding(.trailing, 3)
            }
            .padding(.top, 3)
        }
        .padding(.horizontal , 20)
        .padding(.vertical, 3)
    }
}

//#Preview {
//    GradeChartView(gradeData: [1:3,2:3,3:2])
//}
