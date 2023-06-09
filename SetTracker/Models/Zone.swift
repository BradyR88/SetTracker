//
//  Zone.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import Foundation

struct Zone: Identifiable {
    let id: UUID = UUID()
    
    var names: String
    var climb: [Climb]
}
