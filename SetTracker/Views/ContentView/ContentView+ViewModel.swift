//
//  ContentView+ViewModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/20/24.
//

import Foundation

extension ContentView {
    @Observable
    final class ViewModel {
        
        //MARK: State
        
        var showingSheet = false
        
        //MARK: Actions
        
        func showSheet() {
            showingSheet = true
        }
    }
}
