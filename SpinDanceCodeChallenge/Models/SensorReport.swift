//
//  SensorReport.swift
//  SpinDanceCodeChallenge
//
//  Created by RAVIT on 2/16/20.
//  Copyright © 2020 SpinDance. All rights reserved.
//

import Foundation

struct SensorReport {
    let minTemp: Double
    let maxTemp: Double
    let avgTemp: Double
    let minHumidity: Double
    let maxHumidity: Double
    let avgHumidity: Double
    let minPressure: Int
    let maxPressure: Int
    let avgPressure: Int

    /**
    * convert Temp double to string
    */
    func tempToString(_ value: Double) -> String {
        return String(format: "%.2fº", value)
    }

    /**
    * convert Humidity double to string
    */
    func humidityToString(_ value: Double) -> String {
        return String(format: "%.2f%%", value)
    }

    /**
    * convert Pressure Int to string
    */
    func pressureToString(_ value: Int) -> String {
        return "\(value)"
    }
}
