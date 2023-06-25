//
//  ClimbEditSheet.swift
//  SetTracker
//
//  Created by Brady Robshaw on 6/21/23.
//

import SwiftUI

struct ClimbEditSheet: View {
    @Binding var climb: Climb
    
    var body: some View {
        Form {
            Picker("Grade", selection: $climb.grade.planded) {
                ForEach(0..<13) { vGrade in
                    Text("V\(vGrade)").tag(vGrade)
                }
            }
        }
        .navigationTitle("Zone 1 Climb")
    }
}

//#Preview {
//    Text("test")
//        .sheet(isPresented: .constant(true), content: {
//            ClimbEditSheet(climb: .constant(Climb.examples[0]))
//        })
//    
//}

//#Preview {
//    ClimbEditSheet(climb: .constant(Climb.example))
//}
