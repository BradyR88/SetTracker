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
            Text("V\(climb.grade)")
                .foregroundStyle(climb.color == .black ? Color.white : Color.primary)
                .padding(6)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(climb.color?.uiColor ?? .gray)
                }
                .padding(2)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(climb.color == .white ? Color.black : climb.color?.uiColor ?? .gray)
                }
                
            VStack(alignment: .leading) {
                Text("Setter: \(climb.setter)")
                Text(climb.lastSetDescription)
            }
            .font(.subheadline)
            
            
            Spacer()
            
            if climb.state == .up {
                Image(systemName: "checkmark.circle")
            }
        }
        .foregroundStyle(Color.primary)
    }
}

#Preview {
    var climb = Climb.example
    
    return Button {
        if climb.state == .down {
            climb.state = .up
        } else {
            climb.state = .down
        }
    } label: {
        ClimbDescriptionView(climb: climb)
    }
}
