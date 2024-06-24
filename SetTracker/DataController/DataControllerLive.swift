//
//  DataControllerLive.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/19/24.
//

import Foundation
import SwiftData

struct DataControllerLive: DataController {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    //MARK: functions relevant to climb object
    
    func add(climbs: [Climb], zoneBehavior: ZoneBehavior = .combine) {
        switch zoneBehavior {
        case .combine:
            return
        case .replace(let zones):
            try? modelContext.delete(
                model: Climb.self,
                where: #Predicate { climb in zones.contains(climb.zone) }
            )
        }
        
        for climb in climbs {
            modelContext.insert(climb)
        }
    }
    
    func delete(climbs: [Climb]) {
        for climb in climbs {
            modelContext.delete(climb)
        }
    }
    
    //MARK: functions relevant to Gym object
    
    func add(gym: String) {
        let newGym = Gym(name: gym)
        modelContext.insert(newGym)
    }
    
    func delete(gym: Gym) {
        modelContext.delete(gym)
    }
}
