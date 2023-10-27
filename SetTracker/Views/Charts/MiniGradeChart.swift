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
        Chart(vm.allClimbs ?? []) { barEntry in
            BarMark(
                x: .value("Grade", barEntry.name),
                y: .value("Count", barEntry.number)
            )
            .position(by: .value("Scope", "Zone"))
            .foregroundStyle(Color.green)
        }
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
