//
//  TimeUpDating.swift
//  SetTracker
//
//  Created by Brady Robshaw on 8/12/23.
//

import Foundation

protocol TimeUpDating {
    var daysUp: Int? { get }
    var daysUpDescription: String { get }
}

extension TimeUpDating {
    var daysUpDescription: String {
        guard let daysUp = daysUp else { return "--"}
        return "\(daysUp) Day\(daysUp == 1 ? "" : "s") Ago"
    }
}
