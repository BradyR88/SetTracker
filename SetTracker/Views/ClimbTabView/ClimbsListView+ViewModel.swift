//
//  ClimbsListView+ViewModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/22/24.
//

import Foundation
import SwiftData

extension ClimbsListView {
    @Observable
    final class ViewModel {
        
        //MARK: State
        private var climbs: [Climb] = []
        private let dataController: DataController
        let sort: SortOrder
        
        
        var climbsZoned: [String : [Climb]] {
            var climbsByZone: [String: [Climb]] = [:]
            
            for climb in climbs {
                // Check if the zone already exists in the dictionary
                if climbsByZone[climb.zone] != nil {
                    // If it exists, append the climb to the existing list
                    climbsByZone[climb.zone]?.append(climb)
                } else {
                    // If it doesn't exist, create a new list with the current climb
                    climbsByZone[climb.zone] = [climb]
                }
            }
            
            return climbsByZone
        }
        
        //MARK: Initializer
        
        init(modelContext: ModelContext, sort: SortOrder) {
            self.dataController = DataControllerLive(modelContext: modelContext)
            self.sort = sort
        }
        
        //MARK: Actions
        
        func delete(at offsets: IndexSet) {
            let toBeDelete = offsets.map { self.climbs[$0] }
            self.dataController.delete(climbs: toBeDelete)
        }
        
        func delete(at offsets: IndexSet, from zone: String) {
            let zoneClimbs = self.climbsZoned[zone] ?? []
            let toBeDelete = offsets.map { zoneClimbs[$0] }
            self.dataController.delete(climbs: toBeDelete)
        }
        
        // givs the viewModel a coppy of the climbs so that it can set up the zone sort order and sections
        func processClimbs(_ climbs: [Climb]) {
            self.climbs = climbs
        }
    }
}
