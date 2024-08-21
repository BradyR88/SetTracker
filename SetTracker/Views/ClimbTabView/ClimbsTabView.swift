//
//  ClimbsTabView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/17/24.
//

import SwiftData
import SwiftUI

struct ClimbsTabView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var sortOrder = SortDescriptor(\Climb.grade.vEquivalent)
    let showSheet: () -> Void
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 68)
                .overlay {
                    Text("some controls")
                }
            ClimbsListView(sort: sortOrder, modelContext: modelContext)
        }
        .buttonOverlay {
            showSheet()
        } label: {
            Label("Add Climbs", systemImage: "plus.app")
        }

    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Climb.self, configurations: config)
        
        let example = Climb(grade: Grade(vGrade: 1), gym: Gym(name: "test"))
        return ClimbsTabView(showSheet: {})
            .modelContainer(container)
            .onAppear {
                container.mainContext.insert(example)
            }
    } catch {
        fatalError("Failed to create model container.")
    }
}
