//
//  AllChartsView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/18/23.
//

import SwiftUI

struct AllChartsView: View {
    let vm: ChartsDataModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                GradeChartView(gradeData: vm.gradeCount)
                    .containerRelativeFrame(.horizontal)
                StyleChartView(styleData: vm.styleCount)
                    .containerRelativeFrame(.horizontal)
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .safeAreaPadding(.horizontal, 40)
    }
}

//#Preview {
//    AllChartsView()
//}
