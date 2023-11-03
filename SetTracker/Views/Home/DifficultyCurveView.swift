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
    @State private var rightSkew: Double = 0
    @State private var leftSkew: Double = 0
    
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
            .chartYAxis {
                AxisMarks(values: .automatic(desiredCount: 5))
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 11))
            }
            .frame(height: 200)
            .padding()
        }
        
        Grid(alignment: .leading) {
            GridRow {
                Text("Center: \(center, specifier: "%.1f")")
                Slider(value: $center, in: 0...12)
            }
            GridRow {
                Text("Hight: \(height, specifier: "%.1f")")
                Slider(value: $height, in: 10...40)
            }
            GridRow {
                Text("Right Skew: \(rightSkew, specifier: "%.1f")")
                Slider(value: $rightSkew, in: 0...20)
            }
            GridRow {
                Text("Left Skew: \(leftSkew, specifier: "%.1f")")
                Slider(value: $leftSkew, in: 0...20)
            }
        }
        .onChange(of: center + height + leftSkew + rightSkew) {
            withAnimation {
                difficultyCurve = DifficultyCurve(center: Int(center), hight: Int(height), leftSkew: leftSkew, rightSkew: rightSkew)
            }
        }
        
    }
}

#Preview {
    @State var difficultyCurve = DifficultyCurve()
    
    return DifficultyCurveView(difficultyCurve: $difficultyCurve)
}
