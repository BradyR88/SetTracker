//
//  ChartDataModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/17/23.
//

import Observation
import SwiftUI

@Observable class ChartsViewModel {
    private var allClimbs: [BarEntry]?
    private var allStyle: [BarEntry]?
    private var zoneClimbs: [BarEntry]?
    var difficultyCurve: [BarEntry]?
    
    func setUp(_ climbs: [Climb], zone: [Climb]? = nil) {
        withAnimation {
            self.allClimbs = climbData(climbs: climbs)
            self.allStyle = styleData(climbs: climbs)
            self.zoneClimbs = climbData(climbs: zone ?? [])
            self.difficultyCurve = setDifficultyCurve(curve: climbs.first?.zone?.gym?.difficultyCurve, climbCount: climbs.count)
        }
    }
    
    private func climbData(climbs: [Climb]) -> [BarEntry] {
        return climbs.map {BarEntry(name: String($0.grade), number: 1)}
    }
    
    private func styleData(climbs: [Climb]) -> [BarEntry] {
        climbs.flatMap { climb in
            climb.style.compactMap { style in
                BarEntry(name: style.rawValue, number: 1)
            }
        }
    }
    
    private func setDifficultyCurve(curve: DifficultyCurve?, climbCount: Int) -> [BarEntry] {
        guard let curve else { return [] }
        return curve.goalNormalised(to: climbCount).map { (grade, count) in
            BarEntry(name: String(grade), number: count)
        }
        .sorted(using: KeyPathComparator(\.name))
    }
    
    struct BarEntry: Identifiable {
        var name: String
        var number: Double
        var id: String {
            name
        }
    }
    
    //MARK: All Climbs computed variables
    var allGroupings: [BarEntry] {
        allClimbs?.grouping() ?? []
    }
    
    //MARK: Just zone computed variables
    var zoneGroupings: [BarEntry] {
        zoneClimbs?.grouping() ?? []
    }
    
    //MARK: Style computed variables
    var styleGroupings: [BarEntry] {
        allStyle?.grouping() ?? []
    }
    
    //MARK: Mini Chart
    var miniChart: [BarEntry] {
        guard let allClimbs = allClimbs else { return [] }
        let dicGroop = Dictionary(grouping: allClimbs, by: {$0.name})
        var groupings: [ChartsViewModel.BarEntry] = []
        for grade in 1...11 {
            let ttl = dicGroop[String(grade)]?.reduce(0) { $0 + $1.number } ?? 0
            groupings.append(BarEntry(name: String(grade), number: ttl))
        }
        return groupings.sorted(using: KeyPathComparator(\.name))
    }
}


extension Array where Element == ChartsViewModel.BarEntry {
    func grouping() -> [ChartsViewModel.BarEntry] {
        let dicGroop = Dictionary(grouping: self, by: {$0.name})
        var groupings: [ChartsViewModel.BarEntry] = []
        for (name, entries) in dicGroop {
            let ttl = entries.reduce(0) { $0 + $1.number }
            groupings.append(ChartsViewModel.BarEntry(name: name, number: ttl))
        }
        return groupings.filter { $0.number > 0 }
            .sorted(using: KeyPathComparator(\.name))
    }
}
