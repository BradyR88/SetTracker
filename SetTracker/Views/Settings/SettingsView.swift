//
//  SettingsView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/16/24.
//

import SwiftUI

struct SettingsView: View {
    var showSheet: () -> Void
    
    var body: some View {
        VStack {
            Text("SettingsView")
            Button {
                showSheet()
            } label: {
                Text("Show Sheet")
            }

        }
    }
}

#Preview {
    SettingsView{}
}
