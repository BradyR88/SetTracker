//
//  ZoneBarView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 10/3/23.
//

import SwiftUI

struct ZoneBarView: View {
    let zone: Zone
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(zone.name)
                    .bold()
                Group {
                    Text("Climbs: \(zone.climbs.count)")
                    Text(zone.daysUpDescription)
                }
                .font(.subheadline)
            }
            
            Spacer()
            
            MiniGradeChart(zone: zone)
        }
    }
}

#Preview {
    let zone = Zone(name: "test")
    return ZoneBarView(zone: zone) .frame(height: 100)
    
}
