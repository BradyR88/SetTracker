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
        
        var newZone: String = ""
        var zones: [String] = ["Zone 1", "Zone 2"]
        
        //MARK: Actions
        
        func deleteSetter(_ name: String) {
            setters.removeAll { $0 == name }
        }
        
        func addSetter() {
            guard !newSetter.isEmpty else { return }
            setters.append(newSetter)
            newSetter = ""
        }
        
        func deleteZone(_ name: String) {
            setters.removeAll { $0 == name }
        }
        
        func addZone() {
            guard !newSetter.isEmpty else { return }
            setters.append(newSetter)
            newSetter = ""
        }
    }
}
