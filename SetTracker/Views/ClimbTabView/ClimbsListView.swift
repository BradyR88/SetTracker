//
//  ClimbsListView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/17/24.
//

import SwiftData
import SwiftUI

struct ClimbsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Climb.grade) private var climbs: [Climb]
    
    var body: some View {
        List {
            ForEach(climbs) { climb in
                Text("V\(climb.grade)")
            }
        }
    }
    
    init(sort: SortDescriptor<Climb>) {
        _climbs = Query(filter: #Predicate {
            $0.grade.vEquivalent > 0 // TODO: Placeholder showing how to do a filterd serch
        },sort: [sort])
    }
}

#Preview {
    ClimbsListView(sort: SortDescriptor(\Climb.grade))
}
