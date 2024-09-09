//
//  UserSettings.swift
//  SetTracker
//
//  Created by Brady Robshaw on 9/7/24.
//

import Foundation

enum UserSettings {

    static var zones: [String] {
        get { return zonesInfo.get() }
        set { zonesInfo.set(newValue) }
    }
    
    static var setters: [String] {
        get { return settersInfo.get() }
        set { settersInfo.set(newValue) }
    }

    private static var zonesInfo = UserDefaultInfo(key: "zonesInfo", defaultValue: Array<String>())
    private static var settersInfo = UserDefaultInfo(key: "settersInfo", defaultValue: Array<String>())
}
