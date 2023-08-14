//
//  ColorPicker.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/14/23.
//

import SwiftUI

struct ColorPicker: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var holdColor: HoldColors?
    
    let columns = [
        GridItem(.adaptive(minimum: 40))
    ]
    
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(HoldColors.allCases) { color in
                Button {
                    holdColor = color
                } label: {
                    Circle()
                        .foregroundStyle(color.uiColor)
                        .padding(4)
                        .background {
                            if color == .white && colorScheme == .light {
                                Color.black
                            } else {
                                color.uiColor
                            }
                            
                        }
                        .clipShape(Circle())
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            
            Button {
                holdColor = nil
            } label: {
                Circle()
                    .foregroundStyle(Color.gray)
                    .padding(4)
                    .background{ Color.gray }
                    .clipShape(Circle())
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
        
}

#Preview {
    @State var holdColor: HoldColors? = .blue
    
    return Form {
        Text(holdColor?.rawValue ?? "Nope")
        ColorPicker(holdColor: $holdColor)
    }
}
