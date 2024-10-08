//
//  ClimbLabel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 10/8/24.
//

import SwiftUI

struct ClimbLabel: View {
    
    let grade: String
    let setter: String?
    let date: Date?
    
    var primaryText: String {
        guard let setter = setter else { return grade }
        return grade + " - \(setter)"
    }
    
    
    
    var body: some View {
        HStack {
            Text(primaryText)
            Spacer()
            if let date = date {
                Text(date.formatted(date: .abbreviated, time: .omitted))
            }
        }
    }
}

extension ClimbLabel {
    init (vGrade: Int, setter: String? = nil, date: Date? = nil) {
        self.grade = "V\(String(vGrade))"
        self.setter = setter
        self.date = date
    }
}

#Preview {
    ClimbLabel(grade: "V1", setter: "Brady Robshaw", date: Date())
}
