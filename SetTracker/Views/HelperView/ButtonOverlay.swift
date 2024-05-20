//
//  ButtonOverlay.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/17/24.
//

import SwiftUI

struct ButtonOverlay<Label : View>: ViewModifier {
    let action: () -> Void
    let label: () -> Label
    
    init(
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.action = action
        self.label = label
    }
    
    func body(
        content: Content
    ) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                Button {
                    action()
                } label: {
                    label()
                }
                .padding()
            }
        }
    }
}

extension View {
    func buttonOverlay(
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> some View
    ) -> some View {
        modifier(ButtonOverlay(action: action, label: label))
    }
}

#Preview {
    Text("test")
        .buttonOverlay(action: {
            //
        }, label: {
            Text("test")
        })
        .buttonStyle(.bordered)
}
