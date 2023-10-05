//
//  AllChartsView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/18/23.
//

import SwiftUI

struct AllChartsView: View {
    let climbs: [Climb]
    @Environment(ChartsViewModel.self) var chartVM
    
    var body: some View {
        Group {
            if chartVM.groupings.isEmpty {
                ContentUnavailableView("No Climbs", systemImage: "chart.bar", description: nil)
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        GradeChartView()
                            .containerRelativeFrame(.horizontal)
                        
                        Button {
                            chartVM.setUp(climbs)
                        } label: {
                            Text("update charts")
                        }
                        
                        
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
        .onAppear {
            chartVM.setUp(climbs)
        }
        .onChange(of: climbs) { _, newValue in
            chartVM.setUp(newValue)
        }
    }
}

//#Preview {
//    let data = ChartsDataModel(gym: Gym(name: "Test", zones: []))
//
//    return AllChartsView(data: data)
//}
