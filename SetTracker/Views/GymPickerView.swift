//
//  GymPickerView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/13/23.
//

import SwiftUI
import SwiftData

struct GymPickerView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var gyms: [Gym]
    
    @State private var showAddDialog: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if gyms.isEmpty {
                    ContentUnavailableView("No Gyms", systemImage: "square.stack.3d.up.slash", description: nil)
                } else {
                    List(gyms) { gym in
                        Text(gym.name)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddDialog = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddDialog) {
                AddGymView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    GymPickerView()
        .modelContainer(for: Gym.self, inMemory: true)
}
