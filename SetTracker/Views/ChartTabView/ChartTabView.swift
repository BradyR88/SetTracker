//
//  ChartTabView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/21/24.
//

import SwiftData
import SwiftUI

struct ChartTabView: View {
    @Query(sort: \Climb.grade) private var climbs: [Climb]
    let showSheet: () -> Void

    var body: some View {
        BigGradeBarChart(climbs: climbs)
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
        return ChartTabView(showSheet: {})
            .modelContainer(container)
            .onAppear {
                container.mainContext.insert(example)
            }
    } catch {
        fatalError("Failed to create model container.")
    }
}
