//
//  UserDefaultInfo.swift
//  SetTracker
//
//  Created by Brady Robshaw on 9/7/24.
//

import Foundation


struct UserDefaultInfo<Value> {
    var key: String
    var defaultValue: Value
}

extension UserDefaultInfo {

    func get() -> Value {
        guard let valueUntyped = UserDefaults.standard.object(forKey: self.key) else {
            return self.defaultValue
        }
        guard let value = valueUntyped as? Value else {
            return self.defaultValue
        }
        return value
    }

    func set(_ value: Value) {
        UserDefaults.standard.set(value, forKey: self.key)
    }
}
