//
//  SortEnum.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/27/24.
//

import Foundation


enum SortOrder: String, CaseIterable, Identifiable {
    case date = "Date"
    case grade = "Grade"
    case zone = "Zone"
    
    var id: String { return self.rawValue }
    
    var sortDescriptor: [SortDescriptor<Climb>] {
        switch self {
        case .date:
            [SortDescriptor(\Climb.date)]
        case .grade:
            [SortDescriptor(\Climb.grade.vEquivalent), SortDescriptor(\Climb.date)]
        case .zone:
            [SortDescriptor(\Climb.zone), SortDescriptor(\Climb.grade.vEquivalent)]
        }
    }
}
