//
//  GlobalModelContext.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/16/23.
//

import Foundation
import SwiftData

struct GlobalModelContext {
    static var global = GlobalModelContext()
    
    var modelContext: ModelContext?
    
    init() {
        self.modelContext = nil
    }
}
