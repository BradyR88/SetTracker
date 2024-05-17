//
//  ContentView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/15/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    
    var body: some View {
        TabView {
            Text("Charts")
                .tabItem {
                    Label("Charts", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            ClimbsTabView()
                .tabItem {
                    Label("Climbs", systemImage: "list.bullet.circle")
                }
            
            SettingsView(showSheet: {
                showingSheet = true
            })
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .sheet(isPresented: $showingSheet, content: {
            AddClimbsView()
        })
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Climb.self, configurations: config)
        
        let example = Climb(grade: 1)
        return ContentView()
            .modelContainer(container)
            .onAppear {
                container.mainContext.insert(example)
            }
    } catch {
        fatalError("Failed to create model container.")
    }
}
