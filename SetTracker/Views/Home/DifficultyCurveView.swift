//
//  DifficultyCurveView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/10/23.
//

import SwiftUI
import Charts

struct DifficultyCurveView: View {
    @Binding var difficultyCurve: DifficultyCurve
    
    @State private var height: Double = 20
    @State private var center: Double = 4
    @State private var skew: Double = 0
    
    var body: some View {
        HStack {
            Chart {
                ForEach(difficultyCurve.goalCount.sorted(by: >), id: \.key) { key, value in
                    LineMark(
                        x: .value("Grade", key),
                        y: .value("Count", value)
                    )
                    .foregroundStyle(Color.red)
                    .zIndex(1)
                    
                    PointMark(
                        x: .value("Grade", key),
                        y: .value("Count", value)
                    )
                    .foregroundStyle(Color.red)
                    .zIndex(2)
                }
            }
            .frame(height: 200)
            .padding()
        }
        HStack {
            Text("Center")
            Slider(value: $center, in: 0...12)
        }
        .onChange(of: center) {
            difficultyCurve = DifficultyCurve(center: Int(center), hight: 20, skew: 0)
        }
        
    }
}

#Preview {
    @State var difficultyCurve = DifficultyCurve()
    
    return DifficultyCurveView(difficultyCurve: $difficultyCurve)
}
