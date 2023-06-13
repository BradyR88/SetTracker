//
//  HomeView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/9/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var gyms: [Gym]
    
    @State private var gymId: UUID? = nil
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            Group {
                if let gym = gyms.first(where: { $0.id == gymId}) {
//                    GymSummaryView(gym: gym)
                    EmptyView()
                } else {
                    ContentUnavailableView("No Gym", systemImage: "square.stack.3d.up.slash", description: nil)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Gym")
                }
            }
            .toolbarTitleMenu {
                ForEach(gyms) { gym in
                    Button(gym.name) {
                        gymId = gym.id
                    }
                }
                Button("Add Gym") {
                    showingSheet.toggle()
                }
            }
            .sheet(isPresented: $showingSheet, content: {
                AddGymView()
            })
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Gym(name: "test", zones: [])
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(gyms[index])
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Gym.self, inMemory: true)
}
