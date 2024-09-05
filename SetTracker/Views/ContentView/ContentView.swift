//
//  ContentView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/15/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var viewModel = ContentView.ViewModel()
    
    var body: some View {
        NavigationStack {
            TabView {
                ChartTabView(showSheet: viewModel.showSheet)
                    .tabItem {
                        Label("Charts", systemImage: "chart.line.uptrend.xyaxis")
                    }
                
                ClimbsTabView(showSheet: viewModel.showSheet)
                    .tabItem {
                        Label("Climbs", systemImage: "list.bullet.circle")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
            .sheet(isPresented: $viewModel.showingSheet,
                   content: {
                AddClimbsView(
                    modelContext: modelContext,
                    showingSheet: $viewModel.showingSheet
                )
            })
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Climb.self, configurations: config)
        
        let example = Climb(grade: Grade(vGrade: 1), gym: Gym(name: "test"))
        return ContentView()
            .modelContainer(container)
            .onAppear {
                container.mainContext.insert(example)
            }
    } catch {
        fatalError("Failed to create model container.")
    }
}
