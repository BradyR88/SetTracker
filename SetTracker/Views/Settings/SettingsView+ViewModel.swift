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
        
        private var userSettings: UserSettings = UserSettings.shared
        
        var newSetter: String = ""
        var newZone: String = ""
        
        var setters: [String] {
            userSettings.setters
        }
        var zones: [String] {
            userSettings.zones
        }
        
        //MARK: Actions
        
        func deleteSetter(_ name: String) {
            userSettings.setters.removeAll { $0 == name }
        }
        
        func addSetter() {
            guard !newSetter.isEmpty else { return }
            userSettings.setters.append(newSetter)
            newSetter = ""
        }
        
        func deleteZone(_ name: String) {
            userSettings.zones.removeAll { $0 == name }
        }
        
        func addZone() {
            guard !newZone.isEmpty else { return }
            userSettings.zones.append(newZone)
            newZone = ""
        }
    }
}
