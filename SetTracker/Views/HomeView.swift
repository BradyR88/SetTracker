//
//  HomeView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/9/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(sort: \.name) private var gyms: [Gym]
    
    @State private var gymId: UUID? = nil
    @State private var showingSheet = false
    
    private var selectedGym: Gym? {
        gyms.first { $0.id == gymId }
    }
    private var gymName: String {
        if let gymId = gymId {
            return gyms.first { $0.id == gymId }?.name ?? "Select Gym"
        } else {
            return "Select Gym"
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if !gyms.isEmpty {
                    if let selectedGym = selectedGym {
                        GymSummaryView(gym: selectedGym)
                    } else {
                        ContentUnavailableView("Select a Gym", systemImage: "square.stack.3d.up.slash", description: nil)
                    }
                } else {
                    ContentUnavailableView("No Gym", systemImage: "square.stack.3d.up.slash", description: nil)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(gymName)
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
}

#Preview {
    MainActor.assumeIsolated {
        HomeView()
            .modelContainer(previewContainer)
    }
}
