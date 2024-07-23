//
//  ClimbsListView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/17/24.
//

import SwiftData
import SwiftUI

struct ClimbsListView: View {
    @Bindable var viewModel: ViewModel
    @Query private var climbs: [Climb]
    
    var body: some View {
        List {
            ForEach(climbs) { climb in
                Text("\(climb.grade)")
            }
            .onDelete(perform: { indexSet in
                viewModel.delete(at: indexSet, from: climbs)
            })
        }
    }
    
    init(sort: SortDescriptor<Climb>, modelContext: ModelContext) {
        self.viewModel = ClimbsListView.ViewModel(modelContext: modelContext)
        
        _climbs = Query(filter: #Predicate {
            $0.grade.vEquivalent > 0 // TODO: Placeholder showing how to do a filterd serch
        },sort: [sort])
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Climb.self, configurations: config)
        let modelContext = container.mainContext
        
        //let example = Climb(grade: Grade(vGrade: 1), gym: Gym(name: "test"))
        return ClimbsListView(sort: SortDescriptor(\Climb.grade), modelContext: modelContext)
    } catch {
        fatalError("Failed to create model container.")
    }
    
}
