//
//  UserSettings.swift
//  SetTracker
//
//  Created by Brady Robshaw on 9/7/24.
//

import Foundation

struct UserSettings {
    static let shared = UserSettings()
    
    var setters: Array<String> {
        get { return settersInfo.get() }
        set { settersInfo.set(newValue) }
    }

    var zones: [String] {
        get { return zonesInfo.get() }
        set { zonesInfo.set(newValue) }
    }
    
    private var zonesInfo = UserDefaultInfo(key: "zonesInfo", defaultValue: Array<String>())
    private var settersInfo = UserDefaultInfo(key: "settersInfo", defaultValue: Array<String>())
}
