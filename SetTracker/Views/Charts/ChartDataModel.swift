//
//  ChartDataModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/17/23.
//

import Observation
import SwiftUI

@Observable class ChartsViewModel {
    var climbData: [BarEntry]?
    var zoneClimbs: [Climb]?
    
    func setUp(_ climbs: [Climb], zone: [Climb]? = nil) {
        withAnimation {
            self.climbData = climbData(climbs: climbs)
            self.zoneClimbs = zone
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
    
    var grouping: [String : [BarEntry]] {
        if let climbData {
            return Dictionary(grouping: climbData, by: {$0.name})
        } else {
            return [:]
        }
    }
    
    var groupings: [BarEntry] {
        var groupings: [BarEntry] = []
        for (name, entries) in grouping {
            let ttl = entries.reduce(0) { $0 + $1.number }
            groupings.append(BarEntry(name: name, number: ttl))
        }
        return groupings.filter { $0.number > 0 }
            .sorted(using: KeyPathComparator(\.name))
    }
}
