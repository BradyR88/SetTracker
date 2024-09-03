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
        Group {
            switch self.viewModel.sort {
            case .zone:
                self.zoneList
            default:
                self.simpleList
            }
        }
        .toolbar {
            EditButton()
        }
        .onAppear {
            self.viewModel.processClimbs(self.climbs)
        }
    }
    
    private var simpleList: some View {
        List {
            ForEach(self.climbs) { climb in
                Text("\(climb.grade)")
            }
            .onDelete(perform: { indexSet in
                viewModel.delete(at: indexSet)
            })
        }
    }
    
    private var zoneList: some View {
        List {
            ForEach(self.viewModel.climbsZoned.keys.sorted(), id: \.self) { zone in
                Section {
                    ForEach(self.viewModel.climbsZoned[zone]!) { climb in
                        Text("\(climb.grade)")
                    }
                } header: {
                    Text(zone)
                }
            }
            .onDelete(perform: { indexSet in
                viewModel.delete(at: indexSet)
            })
        }
    }
    
    // MARK: Initializer
    
    init(sort: SortOrder, modelContext: ModelContext) {
        self.viewModel = ClimbsListView.ViewModel(
            modelContext: modelContext,
            sort: sort
        )
        
        _climbs = Query(sort: sort.sortDescriptor)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Climb.self, configurations: config)
        let modelContext = container.mainContext
        
        let example1 = Climb(grade: Grade(vGrade: 1), gym: Gym(name: "test"), zone: "1")
        let example2 = Climb(grade: Grade(vGrade: 2), gym: Gym(name: "test"), zone: "2")
        return ClimbsListView(sort: .zone, modelContext: modelContext)
            .modelContainer(container)
            .onAppear {
                container.mainContext.insert(example1)
                container.mainContext.insert(example2)
            }
    } catch {
        fatalError("Failed to create model container.")
    }
    
}
