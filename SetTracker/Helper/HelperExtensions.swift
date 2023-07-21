//
//  HelperExtensions.swift
//  SetTracker
//
//  Created by Brady Robshaw on 7/8/23.
//

import Foundation

//This extension allows UUID to work with @AppStorage 
extension UUID: RawRepresentable {
    public var rawValue: String {
        self.uuidString
    }

    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        self.init(uuidString: rawValue)
    }
}
