//
//  DataFetcher.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/22/24.
//

import Foundation
import SwiftData

protocol DataFetcher {
    func selectedGym() -> Gym
    func fetch() -> [Climb]
    func fetch(with fetchDescriptor: FetchDescriptor<Climb>) -> [Climb]
    func fetch(for gymID: String) -> [Climb]
}
