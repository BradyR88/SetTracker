//
//  AllChartsView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/18/23.
//

import SwiftUI

struct AllChartsView: View {
    let data: ChartsDataModel
    
    var body: some View {
        if data.isEmpty {
            ContentUnavailableView("No Climbs", systemImage: "chart.bar", description: nil)
        } else {
            ScrollView(.horizontal) {
                LazyHStack {
                    if !data.gradeCount.isEmpty {
                        GradeChartView(gradeData: data.gradeCount)
                            .containerRelativeFrame(.horizontal)
                    }
                    if !data.styleCount.isEmpty {
                        StyleChartView(styleData: data.styleCount)
                            .containerRelativeFrame(.horizontal)
                    }
                }
            }
            .contentMargins(.horizontal, -19, for: .scrollContent)
            .scrollTargetBehavior(.paging)
            .safeAreaPadding(.horizontal, 40)
            .scrollIndicators(.hidden)
        }
    }
}

//#Preview {
//    AllChartsView()
//}
