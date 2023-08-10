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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DifficultyCurveView(difficultyCurve: .constant(DifficultyCurve()))
}
