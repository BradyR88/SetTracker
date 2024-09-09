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
        var newZone: String = ""
        
        var setters: [String] {
            UserSettings.setters
        }
        var zones: [String] {
            UserSettings.zones
        }
        
        //MARK: Actions
        
        func deleteSetter(_ name: String) {
            UserSettings.setters.removeAll { $0 == name }
        }
        
        func addSetter() {
            guard !newSetter.isEmpty else { return }
            UserSettings.setters.append(newSetter)
            newSetter = ""
        }
        
        func deleteZone(_ name: String) {
            UserSettings.zones.removeAll { $0 == name }
        }
        
        func addZone() {
            guard !newZone.isEmpty else { return }
            UserSettings.zones.append(newZone)
            newZone = ""
        }
    }
}
