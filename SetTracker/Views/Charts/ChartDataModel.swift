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
    var zoneClimbs: [BarEntry]?
    
    func setUp(_ climbs: [Climb], zone: [Climb]?) {
        withAnimation {
            self.allClimbs = climbData(climbs: climbs)
            self.zoneClimbs = climbData(climbs: zone ?? [])
        }
    }
    
    func climbData(climbs: [Climb]) -> [BarEntry] {
        return climbs.map {BarEntry(name: String($0.grade), number: 1)}
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
}
