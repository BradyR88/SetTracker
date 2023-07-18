//
//  StyleChartView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/14/23.
//

import SwiftUI
import Charts

struct StyleChartView: View {
    let styleData: [Style : Int]
    
    var body: some View {
        Chart(styleData.sorted(by: >), id: \.key) { key, value in
            SectorMark(angle: .value("Value", value))
                .foregroundStyle(by: .value("Style", key.rawValue))
        }
        .padding()
    }
}

//#Preview {
//    StyleChartView(climbs: [Climb.example])
//}
