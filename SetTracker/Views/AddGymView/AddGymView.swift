//
//  AddGymView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/10/23.
//

import SwiftUI

struct AddGymView: View {
    @State private var gymName: String = ""
    @State private var zoneCount: Int = 3 // need to add 1 because of how the pickerworks
    
    var body: some View {
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
    }
}

#Preview {
    NavigationView{
        AddGymView()
    }
}
