//
//  AddGymView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/10/23.
//

import SwiftUI

struct AddGymView: View {
    @State private var gymName: String = ""
    @State private var zoneCount: Int = 0
    
    var body: some View {
        Form {
            TextField(text: $gymName) {
                Text("Gym Name")
            }
            Picker("Number of Zones", selection: $zoneCount) {
                ForEach(1..<100) { 
                    Text("\($0) Zones").tag($0)
                }
            }
        }
        .navigationTitle("Add Gym")
    }
}

#Preview {
    NavigationView{
        AddGymView()
    }
}
