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
                    .safeAreaPadding(.top, 35)
            }
            .onAppear {
                print("Look -> \(geometry.frame(in: .named("")))")
                print(geometry.frame(in: .global))
            }
        }
    }
}

#Preview {
    EntryPointView()
}
