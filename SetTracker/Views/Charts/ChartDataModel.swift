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
            self.difficultyCurve = setDifficultyCurve(curve: climbs.first?.zone?.gym?.difficultyCurve)
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
    
    private func setDifficultyCurve(curve: DifficultyCurve?) -> [BarEntry] {
        guard let curve else { return [] }
        return curve.goalCount.map { (grade, count) in
            BarEntry(name: String(grade), number: count)
        }
        .sorted(using: KeyPathComparator(\.name))
    }
    
    struct BarEntry: Identifiable {
        var name: String
        var number: Int
        var id: String {
            name
        }
    }
    
    //MARK: All Climbs computed variables
    private var allGrouping: [String : [BarEntry]] {
        allClimbs?.grouping() ?? [:]
    }
    
    var allGroupings: [BarEntry] {
        allGrouping.groupings()
    }
    
    //MARK: Just zone computed variables
    private var zoneGrouping: [String : [BarEntry]] {
        zoneClimbs?.grouping() ?? [:]
    }
    
    var zoneGroupings: [BarEntry] {
        zoneGrouping.groupings()
    }
    
    //MARK: Style computed variables
    private var styleGrouping: [String : [BarEntry]] {
        allStyle?.grouping() ?? [:]
    }
    
    var styleGroupings: [BarEntry] {
        styleGrouping.groupings()
    }
}


extension Array where Element == ChartsViewModel.BarEntry {
    func grouping() -> [String : [ChartsViewModel.BarEntry]] {
        Dictionary(grouping: self, by: {$0.name})
    }
}

extension Dictionary where Key == String, Value == Array<ChartsViewModel.BarEntry> {
    func groupings() -> [ChartsViewModel.BarEntry] {
        var groupings: [ChartsViewModel.BarEntry] = []
        for (name, entries) in self {
            let ttl = entries.reduce(0) { $0 + $1.number }
            groupings.append(ChartsViewModel.BarEntry(name: name, number: ttl))
        }
        return groupings.filter { $0.number > 0 }
            .sorted(using: KeyPathComparator(\.name))
    }
}
