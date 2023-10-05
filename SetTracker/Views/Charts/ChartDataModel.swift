//
//  ChartDataModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/17/23.
//

import Observation
import SwiftUI

@Observable class ChartsViewModel {
    var climbs: [Climb]?
    var zoneClimbs: [Climb]?
    
    func setUp(_ climbs: [Climb], zone: [Climb]? = nil) {
        withAnimation {
            self.climbs = climbs
            self.zoneClimbs = zone
        }
    }
    
    struct BarEntry: Identifiable {
        var name: String
        var number: Int
        var id: String {
            name
        }
    }
    
    var allEntries: [BarEntry] {
        if let climbs {
            return climbs.map {BarEntry(name: String($0.grade), number: 1)}
        } else {
            return []
        }
    }
    
    var grouping: [String : [BarEntry]] {
        Dictionary(grouping: allEntries, by: {$0.name})
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
