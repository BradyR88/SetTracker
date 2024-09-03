//
//  ButtonOverlay.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/17/24.
//

import SwiftUI

struct ButtonOverlay<Label : View>: ViewModifier {
    let overlaping: Bool
    let action: () -> Void
    let label: () -> Label
    
    init(
        overlaping: Bool = false,
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.overlaping = overlaping
        self.action = action
        self.label = label
    }
    
    func body(
        content: Content
    ) -> some View {
        switch overlaping {
        case true:
            self.overlapingView(content: content)
        case false:
            self.nonOverlaping(content: content)
        }
    }
    
    private func button() -> some View {
        Button {
            action()
        } label: {
            label()
        }
        .padding()
        .buttonStyle(.borderedProminent)
    }
    
    private func overlapingView(
        content: Content
    ) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                self.button()
            }
        }
    }
    
    private func nonOverlaping(
        content: Content
    ) -> some View {
        VStack {
            content
                .frame(minHeight: 0, maxHeight: .infinity)
            self.button()
        }
        
    }
}

extension View {
    func buttonOverlay(
        overlaping: Bool = false,
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> some View
    ) -> some View {
        modifier(ButtonOverlay(overlaping: overlaping, action: action, label: label))
    }
}

#Preview {
    HStack {
        Text("**Overlaping** \nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            .buttonOverlay(overlaping: true) {
                //
            } label: {
                Text("test")
            }
        
        Divider()
        
        Text("**Not Overlaping** \nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            .buttonOverlay(overlaping: false) {
                //
            } label: {
                Text("test")
            }
    }
}
