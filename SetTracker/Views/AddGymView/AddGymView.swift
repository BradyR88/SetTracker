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
    @State private var zones: [Zone] = [Zone(name: "Zone 1")]
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextField(text: $gymName) {
                    Text("Gym Name")
                }
                
                Section {
                    ForEach($zones) { $zone in
                        TextField("Zone Name", text: $zone.name)
                    }
                    .onDelete(perform: deleteZone)
                    
                    Button("Add Zone") {
                        addZone()
                    }
                } header: {
                    Text("Zones")
                } footer: {
                    if zones.isEmpty {
                        Text("Gym must have at least one zone.")
                    }
                }
            }
            .navigationTitle("Add Gym")
            .toolbar {
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Button("Save") {
                    save()
                }
            }
            .alert("No Zones", isPresented: $showingAlert, actions: {
                Button {
                    addZone()
                } label: {
                    Text("OK")
                }
            }, message: {
                Text("Gym must have at least one zone.")
            })
            .presentationDetents([.medium])
        }
    }
    
    private func addZone() {
        zones.append(Zone(name: "Zone \(zones.count + 1)"))
    }
    
    private func save() {
        if zones.isEmpty {
            showingAlert.toggle()
        } else {
            withAnimation {
                let newGym = Gym(name: gymName, zones: zones)
                modelContext.insert(newGym)
            }
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private func deleteZone(at offsets: IndexSet) {
        zones.remove(atOffsets: offsets)
    }
}

#Preview {
    Text("test")
        .sheet(isPresented: .constant(true)) {
            AddGymView()
                .presentationDetents([.medium])
        }
    
}
