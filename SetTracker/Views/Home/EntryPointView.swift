//
//  EntryPointView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 10/9/23.
//

import SwiftUI

struct EntryPointView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                NavigationStack {
                    HomeView()
                }
                AllChartsView()
                    .padding(.bottom, 425)
                    .padding(.top, 30)
            }
        }
    }
}

#Preview {
    EntryPointView()
}
