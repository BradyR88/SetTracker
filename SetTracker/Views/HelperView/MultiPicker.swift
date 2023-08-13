//
//  MultiPicker.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/13/23.
//

import SwiftUI

struct MultiPicker<T: CaseIterable & Hashable & RawRepresentable> : View where T.RawValue == String {
    let text: String
    var allItems: [T] = T.allCases as! [T]
    @Binding var selectedItems: [T]
    
    private var stringItems: [String] { selectedItems.map { $0.rawValue } }
    
    let columns = [
        GridItem(.flexible(minimum: 100, maximum: 400)),
        GridItem(.fixed(20))
    ]
    
    var body: some View {
        HStack {
            if selectedItems.isEmpty {
                Text(text)
                    .foregroundStyle(Color.secondary.opacity(0.5))
                Spacer()
            } else {
                TagCloudView(tags: stringItems) { item in
                    Button {
                        selectedItems.removeAll { $0.rawValue == item }
                    } label: {
                        HStack {
                            Text(item)
                                .lineLimit(1)
                            Image(systemName: "x.circle")
                        }
                    }
                    .font(.footnote)
                    .foregroundStyle(Color.primary)
                    .buttonStyle(.bordered)
                    
                }
            }
            
            Menu {
                ForEach(allItems, id: \.self) { item in
                    if !selectedItems.contains(item) {
                        Button(item.rawValue) {
                            selectedItems.append(item)
                        }
                    }
                }
            } label: {
                Label("Add Style", systemImage: "plus")
                    .labelStyle(.iconOnly)
            }

        }
    }
}

#Preview {
    MultiPicker(text: "test", allItems: Style.allCases, selectedItems: .constant([.dino]))
}
