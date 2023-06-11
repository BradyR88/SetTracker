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
    
    @State private var gymIndex: Int = 0
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gyms) { gym in
                    Text("gym name: \(gym.name)")
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                
                
                ToolbarItem(placement: .principal) {
                    Text("asdf")
                }
            }
            .toolbarTitleMenu {
                ForEach(gyms.indices) { index in
                    Button(gyms[index].name) {
                        gymIndex = index
                    }
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
