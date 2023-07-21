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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 73, maximum: 200))], content: {
                    ForEach(selectedItems, id: \.self) { item in
                        Button {
                            selectedItems.removeAll { $0 == item}
                        } label: {
                            HStack {
                                Text(item.rawValue)
                                    .lineLimit(1)
                                Image(systemName: "x.circle")
                            }
                        }
                        .font(.footnote)
                        .foregroundStyle(Color.primary)
                        .buttonStyle(.bordered)
                    }
                })
                .frame(maxWidth: .infinity)
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

//struct MultiPicker_Preview: PreviewProvider {
//    static var previews: some View {
//        MultiPicker(allItems: ["0","1","2"], selectedItems: .constant([]))
//    }
//}

//#Preview {
//    MultiPicker(allItems: ["0","1","2"], selectedItems: .constant([]))
//}
