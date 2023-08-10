//
//  DifficultyCurveView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/10/23.
//

import SwiftUI

struct DifficultyCurveView: View {
    @Binding var difficultyCurve: DifficultyCurve
    
    var body: some View {
        ForEach(difficultyCurve.goalCount.sorted(by: <), id: \.key) { grade, value in
            Text("grade: \(grade) - count: \(value)")
        }
    }
}

#Preview {
    DifficultyCurveView(difficultyCurve: .constant(DifficultyCurve()))
}
