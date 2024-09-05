//
//  SettingsView+ViewModel.swift
//  SetTracker
//
//  Created by Brady Robshaw on 9/5/24.
//

import Foundation

extension SettingsView {
    @Observable
    final class ViewModel {
        
        //MARK: State
        
        var newSetter: String = ""
        var setters = ["Brady", "James"]
        
        //MARK: Actions
        
        func deleteSetter(_ name: String) {
            setters.removeAll { $0 == name }
        }
        
        func addSetter() {
            guard !newSetter.isEmpty else { return }
            setters.append(newSetter)
            newSetter = ""
        }
    }
}
