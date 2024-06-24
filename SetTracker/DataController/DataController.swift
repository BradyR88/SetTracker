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
    func add(climbs: [Climb], zoneBehavior: ZoneBehavior)
    func delete(climbs: [Climb])
    
    //MARK: functions relevant to Gym object
    func add(gym: String)
    func delete(gym: Gym)
}

enum ZoneBehavior: CaseIterable, CustomStringConvertible {
    case combine
    case replace(zones: Array<String>)
    
    var description: String {
        switch self {
        case .combine:
            "Combine"
        case .replace(_):
            "Replace"
        }
    }
    
    static var allCases: [ZoneBehavior] {
        [.combine, .replace(zones: [])]
    }
}
