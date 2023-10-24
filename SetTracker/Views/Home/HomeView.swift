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
    @Query(sort: \Gym.name) private var gyms: [Gym]
    
    @AppStorage("gymId") var gymId: UUID?
    @State private var showingSheet = false
    @State private var showingAlert = false
    
    private var selectedGym: Gym? {
        gyms.first { $0.id == gymId }
    }
    private var gymName: String {
        selectedGym?.name ?? "Select Gym"
    }
    
    var body: some View {
        Group {
            if !gyms.isEmpty {
                if let selectedGym = selectedGym {
                    // this is what's being shown everything else is just figuring out the correct unavailable view to show
                    GymSummaryView(gym: selectedGym)
                } else {
                    ContentUnavailableView("Select a Gym", systemImage: "square.stack.3d.up.slash", description: nil)
                }
            } else {
                ContentUnavailableView {
                    Label("No Gyms", systemImage: "square.stack.3d.up.slash")
                } actions: {
                    Button("Add Gym") {
                        showingSheet = true
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .alert("Delete gym", isPresented: $showingAlert, actions: {
            Button("Delete", role: .destructive) {
                withAnimation {
                    let toBeDeleted = selectedGym
                    modelContext.delete(toBeDeleted!)
                    gymId = gyms.first?.id
                }
            }
        }, message: {
            Text("This will permunuty delete this gym, as well as all corresponding zones and climbs!")
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("Add Gym") {
                        showingSheet.toggle()
                    }
                    
                    //Delete Gym
                    if selectedGym != nil {
                        Button("Delete Gym", role: .destructive) {
                            showingAlert = true
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
            
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
        }
        .sheet(isPresented: $showingSheet, content: {
            AddGymView()
        })
        .coordinateSpace(name: "HomeView")
    }
}

#Preview {
    HomeView()
        .modelContainer(previewContainer)
}
