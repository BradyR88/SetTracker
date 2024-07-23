//
//  DataFetcherLive.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/22/24.
//

import Foundation
import SwiftData

struct DataFetcherLive: DataFetcher {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    //MARK: DataFetcher Frotocol Functions
    
    func selectedGym() -> Gym {
        let gymID: String = UserDefaults.standard.object(forKey: "gymId") as? String ?? ""
        let gymUUID = UUID(uuidString: gymID) ?? UUID()
        let fetchDescriptor = FetchDescriptor<Gym>(predicate: #Predicate { gym in
             gym.id == gymUUID
        })
        let gyms = self.fetch(fetchDescriptor: fetchDescriptor)
        return gyms.first ?? Gym(name: "New Gym")
    }
    
    func fetch() -> [Climb] {
        let fetchDescriptor = FetchDescriptor<Climb>()
        return self.fetch(fetchDescriptor: fetchDescriptor)
    }
    
    func fetch(with fetchDescriptor: FetchDescriptor<Climb>) -> [Climb] {
        return self.fetch(fetchDescriptor: fetchDescriptor)
    }
    
    func fetch(for gymID: String) -> [Climb] {
        let gymUUID = UUID(uuidString: gymID) ?? UUID()
        let fetchDescriptor = FetchDescriptor<Climb>(predicate: #Predicate { climb in
            climb.gym.id == gymUUID
        })
        return self.fetch(fetchDescriptor: fetchDescriptor)
    }
    
    
    //MARK: helper functions
    private func fetch<T>(fetchDescriptor: FetchDescriptor<T>) -> [T] {
        do {
            let fetchedClimbs = try modelContext.fetch(fetchDescriptor)
            return fetchedClimbs
        } catch {
            fatalError("Failed to load SwiftData Model in DataFetcherLive\n\(T.schemaMetadata)")
        }
    }
}
