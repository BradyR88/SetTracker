//
//  BigGradeBarChart+ViewModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/21/24.
//

import Foundation

extension BigGradeBarChart {
    @Observable
    final class ViewModel {
        let chartData: [BarEntry]

        init(climbs: [Climb]) {
            let barEntrys = climbs.map {BarEntry(name: $0.grade.description, number: 1)}
            let data = barEntrys.grouping()
            self.chartData = data
        }
    }
}
