//
//  StyleChartView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/14/23.
//

import SwiftUI
import Charts

//struct StyleChartView: View {
//    let styleData: [Style : Int]
//    let zoneStyleData: [Style : Int] = [:]
//    var body: some View {
//        ZStack {
//            Chart(styleData.sorted(by: >), id: \.key) { key, value in
//                    SectorMark(
//                        angle: .value("Value", value),
//                        innerRadius: .ratio(0.5),
//                        angularInset: 4
//                    )
//                    .foregroundStyle(by: .value("Style", key.rawValue))
//                    .cornerRadius(7)
//            }
//            
//            Chart(zoneStyleData.sorted(by: >), id: \.key) { key, value in
//                SectorMark(
//                    angle: .value("Value", value),
//                    outerRadius: .ratio(0.45),
//                    angularInset: 4
//                )
//                .foregroundStyle(by: .value("Style", key.rawValue))
//                .cornerRadius(7)
//            }
//            
//        }
//        .padding(.horizontal, 20)
//        .padding(.vertical)
//    }
//}
//
//#Preview {
//    let example = [Style.crimp : 4, Style.crimp : 3, Style.sloper : 5]
//    return StyleChartView(styleData: example)
//}
