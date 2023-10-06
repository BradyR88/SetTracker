//
//  AllChartsView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/18/23.
//

import SwiftUI

struct AllChartsView: View {
    @Environment(ChartsViewModel.self) var chartVM
    
    var body: some View {
        Group {
            if chartVM.allGroupings.isEmpty {
                ContentUnavailableView("No Climbs", systemImage: "chart.bar", description: nil)
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        GradeChartView()
                            .containerRelativeFrame(.horizontal)
                        
                        //                    if !data.styleCount.isEmpty {
                        //                        StyleChartView()
                        //                            .containerRelativeFrame(.horizontal)
                        //                    }
                    }
                }
                .scrollTargetBehavior(.paging)
                .scrollIndicators(.hidden)
            }
        }
    }
}

//#Preview {
//    let data = ChartsDataModel(gym: Gym(name: "Test", zones: []))
//
//    return AllChartsView(data: data)
//}
