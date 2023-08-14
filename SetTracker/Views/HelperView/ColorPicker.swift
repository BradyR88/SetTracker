//
//  ColorPicker.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/14/23.
//

import SwiftUI

struct ColorPicker: View {
    @Binding var color: HoldColors?
    
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(HoldColors.allCases) { color in
                color.uiColor
                    .clipShape(Circle())
                    .frame(height: 50)
            }
        }
    }
}

#Preview {
    ColorPicker(color: .constant(HoldColors.red))
}
