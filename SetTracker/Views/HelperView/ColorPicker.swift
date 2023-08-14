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
        GridItem(.adaptive(minimum: 30))
    ]
    
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(HoldColors.allCases) { color in
                Button {
                    withAnimation {
                        holdColor = color
                    }
                } label: {
                    Circle()
                        .foregroundStyle(color.uiColor)
                        .padding(3)
                        .background {
                            if color == .white && colorScheme == .light {
                                Color.gray
                            } else {
                                color.uiColor
                            }
                        }
                        .overlay {
                            if color == holdColor {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .padding(10)
                                    .foregroundStyle(color == .black ? Color.white : Color.black)
                            }
                        }
                        .clipShape(Circle())
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            
            Button {
                withAnimation {
                    holdColor = nil
                }
            } label: {
                Circle()
                    .foregroundStyle(Color.gray)
                    .padding(4)
                    .background{ Color.gray }
                    .overlay {
                        if holdColor == nil {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .foregroundStyle(colorScheme == .light ? Color.black : Color.white)
                        }
                    }
                    .clipShape(Circle())
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .sensoryFeedback(.selection, trigger: holdColor)
    }
        
}

#Preview {
    @State var holdColor: HoldColors? = .blue
    
    return Form {
        Text(holdColor?.rawValue ?? "Nope")
        ColorPicker(holdColor: $holdColor)
    }
}
