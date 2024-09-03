//
//  SortBarView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/27/24.
//

import SwiftUI

struct SortBarView: View {
    @Binding var sortOrder: SortOrder
    
    var body: some View {
        Picker(selection: self.$sortOrder) {
            ForEach(SortOrder.allCases) { item in
                Text(item.rawValue)
                    .tag(item)
            }
        } label: {
            Text("Sort Order")
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}

#Preview {
    @State var sortOrder: SortOrder = .grade
    return SortBarView(sortOrder: $sortOrder)
}
