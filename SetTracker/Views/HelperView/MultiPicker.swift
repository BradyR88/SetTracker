//
//  MultiPicker.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/13/23.
//

import SwiftUI

struct MultiPicker<T: CaseIterable & Hashable & RawRepresentable> : View where T.RawValue == String {
    var allItems: [T] = T.allCases as! [T]
    @Binding var selectedItems: [T]
    
    var body: some View {
        HStack {
            ForEach(selectedItems, id: \.self) { item in
                Text(item.rawValue)
            }
            
            Spacer()
            
            Menu {
                ForEach(allItems, id: \.self) { item in
                    Button(item.rawValue) {
                        selectedItems.append(item)
                    }
                }
            } label: {
                Label("Add Style", systemImage: "plus")
                    .labelStyle(.iconOnly)
            }

        }
    }
}

//struct MultiPicker_Preview: PreviewProvider {
//    static var previews: some View {
//        MultiPicker(allItems: ["0","1","2"], selectedItems: .constant([]))
//    }
//}

//#Preview {
//    MultiPicker(allItems: ["0","1","2"], selectedItems: .constant([]))
//}
