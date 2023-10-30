//
//  MiniGradeChart.swift
//  SetTracker
//
//  Created by Brady Robshaw on 10/26/23.
//

import SwiftUI
import Charts

struct MiniGradeChart: View {
    let zone: Zone
    @Bindable private var vm = ChartsViewModel()
    
    var body: some View {
        Chart(vm.allGroupings) { barEntry in
            BarMark(
                x: .value("Grade", barEntry.name),
                y: .value("Count", barEntry.number)
            )
            //.position(by: .value("Scope", "Zone"))
            .foregroundStyle(Color.green)
        }
//        .chartXScale(domain: 0...12)
//        .chartXAxis {
//            AxisMarks(values: [0,1,2,3,4,5,6,7,8,9,10,11]) { value in
//                AxisGridLine()
//                AxisTick()
//            }
//        }
        .frame(height: 50)
        .padding(.horizontal , 20)
        .padding(.vertical)
        .onAppear {
            vm.setUp(zone.climbs)
        }
    }
}

//#Preview {
//    MiniGradeChart(zone: Z)
//}
