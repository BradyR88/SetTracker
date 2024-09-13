//
//  DataController.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/19/24.
//

import Foundation
import SwiftData

protocol DataController {
    
    //MARK: functions relevant to climb object
    func add(climbs: [Climb], integrationMethod: IntegrationMethod, zones: [String])
    func delete(climbs: [Climb])
    
    //MARK: functions relevant to Gym object
    func add(gym: String)
    func delete(gym: Gym)
}
