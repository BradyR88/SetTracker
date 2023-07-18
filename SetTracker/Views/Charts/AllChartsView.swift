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
                    GradeChartView(gradeData: data.gradeCount)
                        .containerRelativeFrame(.horizontal)
                    StyleChartView(styleData: data.styleCount)
                        .containerRelativeFrame(.horizontal)
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, 40)
        }
    }
}

//#Preview {
//    AllChartsView()
//}
