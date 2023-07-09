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
                
                TextField("Seter", text: $climb.seter)
                
                DatePicker("Day Set", selection: $climb.dateUp, displayedComponents: .date)
            }
        }
    }
}

//#Preview {
//    ClimbEditSheet(climb: Climb.example, selectedClimb: .constant(nil))
//        .modelContainer(previewContainer)
//}
