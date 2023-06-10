//
//  Zone.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import Foundation

struct Zone: Codable {
    let id: String
    
    var name: String
    var climb: [Climb]
}
