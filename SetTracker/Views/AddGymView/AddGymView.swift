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
    @State private var zoneCount: Int = 3 // need to add 1 because of how the pickerworks
    
    var body: some View {
        NavigationStack {
            Form {
                TextField(text: $gymName) {
                    Text("Gym Name")
                }
                Picker("Number of Zones", selection: $zoneCount) {
                    ForEach(1..<100) { num in
                        Text("\(num) Zones")
                    }
                }
                Text("\(zoneCount)")
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
}

#Preview {
    Text("test")
        .sheet(isPresented: .constant(true)) {
            AddGymView()
                .presentationDetents([.medium])
        }
    
}
