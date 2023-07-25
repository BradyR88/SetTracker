//
//  Chartable.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/25/23.
//

import Foundation

protocol Chartable {
    var climbs: [Climb] { get set }
    
    var chartData: ChartsDataModel { get }
}
