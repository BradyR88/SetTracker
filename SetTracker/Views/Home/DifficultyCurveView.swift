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
    
    @State private var editMode: Bool = false
    @State private var height: Double = 20
    @State private var center: Double = 4
    @State private var rightSkew: Double = 0
    @State private var leftSkew: Double = 0
    
    var body: some View {
        VStack {
            Chart {
                ForEach(difficultyCurve.goalPersent.sorted(by: >), id: \.key) { key, value in
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
                AxisMarks(format: Decimal.FormatStyle.Percent.percent.scale(1), values: .automatic(desiredCount: 5))
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 11))
            }
            .frame(height: 200)
            .padding()
            
            Picker("Edit Mode", selection: $editMode) {
                Text("Sliders").tag(false)
                Text("Precise").tag(true)
            }
            .pickerStyle(.segmented)
            
            if editMode {
                ForEach(difficultyCurve.goalCount.sorted(by: <), id: \.key) { grade, value in
                    Stepper("Grade\(grade) - \(value)") {
                        difficultyCurve.onIncrement(of: grade)
                    } onDecrement: {
                        difficultyCurve.onDecrement(of: grade)
                    }
                }
            } else {
                Grid(alignment: .leading) {
                    GridRow {
                        Text("Center: \(center, specifier: "%.1f")")
                        Slider(value: $center, in: 0...12)
                    }
                    GridRow {
                        ZStack(alignment: .leading) {
                            Text("Right Skew: \(rightSkew, specifier: "%.1f")")
                            Text("Right Skew: 20.0") // this is the longest the text will ever be, and this is here and invisible to stop the grid from slightly shifting in size whenever this number changes
                                .foregroundStyle(Color.clear)
                        }
                        Slider(value: $rightSkew, in: 0...20)
                    }
                    GridRow {
                        Text("Left Skew: \(leftSkew, specifier: "%.1f")")
                        Slider(value: $leftSkew, in: 0...20)
                    }
                }
            }
        }
        .onChange(of: center + height + leftSkew + rightSkew) {
            withAnimation {
                difficultyCurve = DifficultyCurve(center: Int(center), hight: 35, leftSkew: leftSkew, rightSkew: rightSkew)
            }
        }
        
    }
}

#Preview {
    @State var difficultyCurve = DifficultyCurve()
    
    return DifficultyCurveView(difficultyCurve: $difficultyCurve)
}
