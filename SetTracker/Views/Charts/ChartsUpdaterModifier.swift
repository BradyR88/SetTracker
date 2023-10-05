//
//  ChartsUpdaterModifier.swift
//  SetTracker
//
//  Created by Brady Robshaw on 10/5/23.
//

import SwiftUI

struct ChartsUpdater: ViewModifier {
    @Environment(ChartsViewModel.self) var chartVM
    var climbs: [Climb]
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                chartVM.setUp(climbs)
            }
            .onChange(of: climbs) { _, newValue in
                chartVM.setUp(newValue)
            }
    }
}

extension View {
    func chartUpdater(for climbs: [Climb]) -> some View {
        modifier(ChartsUpdater(climbs: climbs))
    }
}
