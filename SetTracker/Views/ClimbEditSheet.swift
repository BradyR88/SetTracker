//
//  ClimbEditSheet.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/21/23.
//

import SwiftUI

struct ClimbEditSheet: View {
    @Bindable var climb: Climb
    let onDone: () -> Void
    
    @State var expandedForm = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") {
                    onDone()
                }
                .padding(.trailing)
                .buttonStyle(.bordered)
            }
            
            Form {
                Picker("Grade", selection: $climb.grade) {
                    ForEach(0..<13) { vGrade in
                        Text("V\(vGrade)").tag(vGrade)
                    }
                }
                
                TextField("Setter", text: $climb.setter)
                
//                if climb.state != .seting {
//                    DatePicker("Day Set", selection: $climb.dateUp, displayedComponents: .date)
//                }
                
                Section {
                    Button("Done Setting") {
                        climb.state = .up
                    }
                    .frame(maxWidth: .infinity)
                    .tint(.green)
                }
            }
        }
    }
}

//#Preview {
//    ClimbEditSheet(climb: Climb.example, onDone: {})
//        .modelContainer(previewContainer)
//}
