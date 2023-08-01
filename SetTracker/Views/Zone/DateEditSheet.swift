//
//  DateEditSheet.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/1/23.
//

import SwiftUI
import SwiftData

struct DateEditSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var zone: Zone
    @State private var date: Date
    @State private var editAll: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("Last set", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                zone.lastSetDate(is: date, editAll: editAll)
                                dismiss()
                            }
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                    }
                Toggle("Edit All", isOn: $editAll)
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    init(zone: Zone) {
        self.zone = zone
        _date = State(initialValue: zone.dateOfLastSet)
        if zone.daysSinceLastSet == nil {
            _editAll = State(initialValue: true)
        } else {
            _editAll = State(initialValue: false)
        }
        
    }
}

//#Preview {
//    DateEditSheet()
//}
