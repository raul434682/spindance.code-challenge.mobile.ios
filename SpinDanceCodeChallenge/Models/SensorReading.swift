//
//  SensorReading.swift
//  SpinDanceCodeChallenge
//
//  Created by Robert Hartman on 2/13/20.
//  Copyright © 2020 SpinDance. All rights reserved.
//

import Foundation

struct SensorReading {
    let temp: Double
    let humidity: Double
    let pressure: Int
    let time: Date
}

extension SensorReading: Comparable {
    static func < (lhs: SensorReading, rhs: SensorReading) -> Bool {
        lhs.time < rhs.time
    }
}
