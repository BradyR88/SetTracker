//
//  Zone.swift
//  Set Track
//
//  Created by Brady Robshaw on 6/9/23.
//

import SwiftData
import Foundation

@Model
final class Zone {
    let id: UUID
    var name: String
    @Relationship(deleteRule: .cascade) var climbs: [Climb]
    @Relationship(deleteRule: .cascade) var oldClimbs: [Climb]
    
    var gym: Gym?
    
    var dateOfLastSet: Date {
        var date: Date = Date()
        
        guard !climbs.isEmpty else { return Date() }
        for climb in climbs {
            if date > climb.safeDateUp {
                date = climb.safeDateUp
            }
        }
        return date
    }
    
    /// Deletes relevant Climb from Climbs list. Does not go into oldClimbs.
    func delete(_ climb: Climb) {
        climbs.removeAll { _climb in
            climb.id == _climb.id
        }
        GlobalModelContext.global.modelContext?.delete(climb.self)
    }
    
    func lastSetDate(is date: Date, editAll: Bool) {
        for climb in climbs {
            if editAll || climb.state == .up {
                climb.safeDateUp = date
            }
        }
    }
    
    /// Marks all climbs in a zone as up 
    func setComplete() {
        climbs.forEach { climb in
            climb.state = .up
        }
    }
    
    /// Sets climb state as .down and moves it to oldClimbs
    func strip(climb: Climb) {
        climb.state = .down
        oldClimbs.append(climb)
        climbs.removeAll { $0 == climb }
        GlobalModelContext.global.modelContext?.delete(climb.self)
    }
    
    /// Add oldClimb back into the Climb list and marks its state as .up
    func reinstate(_ climb: Climb) {
        for (index, oldClimb) in oldClimbs.enumerated() {
            if oldClimb.id == climb.id {
                oldClimb.state = .up
                climbs.append(oldClimb)
                oldClimbs.remove(at: index)
                break
            }
        }
    }
    
    ///Sets all climbs as .down and moves all climbs to oldClimbs
    func reset(on date: Date = Date()) {
        climbs.forEach { climb in
            climb.state = .down
            //TODO: this is not the best way to do this use a predicate to remove all climbs in this zone at the same time not one at a time in a loop
            GlobalModelContext.global.modelContext?.delete(climb.self)
        }
        oldClimbs.append(contentsOf: climbs)
        climbs.removeAll()
    }
    
    init(name: String, climb: [Climb] = []) {
        self.id = UUID()
        self.name = name
        self.climbs = climb
        self.oldClimbs = []
    }
}

extension Zone {
    enum DisplayMode {
        case currentClimbs, oldClimbs
        
        var toggleButtonText: String {
            switch self {
            case .currentClimbs:
                "Old Climbs"
            case .oldClimbs:
                "Current Climbs"
            }
        }
    }
}

extension Zone: Comparable {
    //TODO: provide multiple sort options, so the view can't decide what type of sort it wants
    static func < (lhs: Zone, rhs: Zone) -> Bool {
        lhs.name < rhs.name
    }
}

extension Zone: TimeUpDating {
    var daysUp: Int? {
        var days: Int? = nil
        
        guard !climbs.isEmpty else { return nil }
        
        for climb in climbs {
            if days == nil {
                days = climb.daysUp
            } else if let daysUp = climb.daysUp {
                if daysUp < days! {
                    days = daysUp
                }
            }
        }
        
        return days
    }
}
