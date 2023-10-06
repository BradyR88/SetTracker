//
//  ChartDataModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/17/23.
//

import Observation
import SwiftUI

@Observable class ChartsViewModel {
    var allClimbs: [BarEntry]?
    var allStyle: [BarEntry]?
    var zoneClimbs: [BarEntry]?
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
    var allGrouping: [String : [BarEntry]] {
        if let allClimbs {
            return Dictionary(grouping: allClimbs, by: {$0.name})
        } else {
            return [:]
        }
    }
    
    var allGroupings: [BarEntry] {
        var groupings: [BarEntry] = []
        for (name, entries) in allGrouping {
            let ttl = entries.reduce(0) { $0 + $1.number }
            groupings.append(BarEntry(name: name, number: ttl))
        }
        return groupings.filter { $0.number > 0 }
            .sorted(using: KeyPathComparator(\.name))
    }
    
    //MARK: Just zone computed variables
    var zoneGrouping: [String : [BarEntry]] {
        if let zoneClimbs {
            return Dictionary(grouping: zoneClimbs, by: {$0.name})
        } else {
            return [:]
        }
    }
    
    var zoneGroupings: [BarEntry] {
        var groupings: [BarEntry] = []
        for (name, entries) in zoneGrouping {
            let ttl = entries.reduce(0) { $0 + $1.number }
            groupings.append(BarEntry(name: name, number: ttl))
        }
        return groupings.filter { $0.number > 0 }
            .sorted(using: KeyPathComparator(\.name))
    }
    
    //MARK: Style computed variables
    var styleGrouping: [String : [BarEntry]] {
        if let allStyle {
            return Dictionary(grouping: allStyle, by: {$0.name})
        } else {
            return [:]
        }
    }
    
    var styleGroupings: [BarEntry] {
        var groupings: [BarEntry] = []
        for (name, entries) in styleGrouping {
            let ttl = entries.reduce(0) { $0 + $1.number }
            groupings.append(BarEntry(name: name, number: ttl))
        }
        return groupings.filter { $0.number > 0 }
            .sorted(using: KeyPathComparator(\.name))
    }
}
