//
//  ClimbDescriptionView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/12/23.
//

import SwiftUI

struct ClimbDescriptionView: View {
    var climb: Climb
    
    var body: some View {
        HStack {
            switch climb.state {
            case .inProgress:
                Image(systemName: "seal.fill")
                    .tint(climb.color?.uiColor ?? .gray)
            case .up:
                Image(systemName: "checkmark.seal.fill")
                    .tint(climb.color?.uiColor ?? .gray)
            case .down:
                Image(systemName: "delete.forward.fill")
                    .tint(climb.color?.uiColor ?? .gray)
            }
                
            Text(climb.description)
                .tint(.primary)
            Spacer()
            if let daysUp = climb.daysUp {
                Text("\(daysUp)")
                    .tint(.primary)
            }
        }
    }
}

//#Preview {
//    ClimbDescriptionView(climb: Climb.example)
//}
