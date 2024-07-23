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
        private let dataController: DataController
        
        //MARK: Initializer
        
        init(modelContext: ModelContext) {            
            self.dataController = DataControllerLive(modelContext: modelContext)
        }
        
        //MARK: Actions
        
        func delete(at offsets: IndexSet, from climbs: [Climb]) {
            let toBeDelete = offsets.map { climbs[$0] }
            dataController.delete(climbs: toBeDelete)
        }
    }
}
