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
    let zoneStyleData: [Style : Int] = [:] //previewExamples.exampleStyleData
    var body: some View {
        ZStack {
            Chart(styleData.sorted(by: >), id: \.key) { key, value in
                    SectorMark(
                        angle: .value("Value", value),
                        innerRadius: .ratio(0.5),
                        angularInset: 4
                    )
                    .foregroundStyle(by: .value("Style", key.rawValue))
                    .cornerRadius(7)
            }
            
            Chart(zoneStyleData.sorted(by: >), id: \.key) { key, value in
                SectorMark(
                    angle: .value("Value", value),
                    outerRadius: .ratio(0.45),
                    angularInset: 4
                )
                .foregroundStyle(by: .value("Style", key.rawValue))
                .cornerRadius(7)
            }
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical)
    }
}

//struct Preview_StyleChartView: PreviewProvider {
//    static var previews: some View {
//        StyleChartView(styleData: [.bored : 4, .crimp : 3, .sloper : 5])
//    }
//}


//#Preview {
//    StyleChartView(styleData: [.bored : 4, .crimp : 3, .sloper : 5])
//}
