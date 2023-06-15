//
//  AddGymView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/10/23.
//

import SwiftUI

struct AddGymView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var gymName: String = ""
    @State private var zones: [Zone] = []
    
    var body: some View {
        NavigationStack {
            Form {
                TextField(text: $gymName) {
                    Text("Gym Name")
                }
                
                Section("Zones") {
                    ForEach($zones) { $zone in
                        TextField("Zone Name", text: $zone.name)
                    }
                    
                    Button("Add Zone") {
                        addZone()
                    }
                }
            }
            .navigationTitle("Add Gym")
            .toolbar {
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Button("Save") {
                    let idea = Gym(name: gymName, zones: [])
                    modelContext.insert(idea)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .presentationDetents([.medium])
        }
    }
    
    private func addZone() {
        zones.append(Zone(name: "Zone \(zones.count + 1)"))
    }
    
    private func save() {
        withAnimation {
            let newGym = Gym(name: gymName, zones: zones)
            modelContext.insert(newGym)
        }
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    Text("test")
        .sheet(isPresented: .constant(true)) {
            AddGymView()
                .presentationDetents([.medium])
        }
    
}
