//
//  BigGradeBarChart.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/21/24.
//

import Charts
import SwiftData
import SwiftUI

struct BigGradeBarChart: View {
    var viewModel: BigGradeBarChart.ViewModel

    init(climbs: [Climb]) {
        self.viewModel = BigGradeBarChart.ViewModel(climbs: climbs)
    }

    var body: some View {
        Chart {
            ForEach(viewModel.chartData) { barEntry in
                BarMark(
                    x: .value("Grade", barEntry.name),
                    y: .value("Count", barEntry.number)
                )
                .position(by: .value("Scope", "Gym"))
                .zIndex(0)
            }
        }
        .chartForegroundStyleScale(["Revenue": Color.green, "Visits": Color.purple])
        .chartLegend(.visible)
        .chartLegend(position: .bottom) {
            HStack(spacing: 3) {
                BasicChartSymbolShape.circle.foregroundStyle(Color.blue).frame(width: 8, height: 8)
                Text("Gym")
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .padding(.trailing, 3)
                BasicChartSymbolShape.circle.foregroundStyle(Color.red).frame(width: 8, height: 8)
                Text("Target")
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .padding(.trailing, 3)
            }
            .padding(.top, 3)
        }
        .padding(.horizontal , 20)
        .padding(.vertical, 3)
    }
}

#Preview {
    BigGradeBarChart(climbs: [Climb(grade: Grade(vGrade: 1), gym: Gym(name: "test"))])
}
