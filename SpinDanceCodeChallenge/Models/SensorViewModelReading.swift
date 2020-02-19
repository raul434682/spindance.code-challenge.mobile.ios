//
//  SensorViewModelReading.swift
//  SpinDanceCodeChallenge
//
//  Created by RAVIT on 2/16/20.
//  Copyright © 2020 SpinDance. All rights reserved.
//
import Foundation

struct SensorViewModelReading {
    let temp: Double
    let humidity: Double
    let pressure: Int
    let time: Date
    
    /**
    * convert Temp double to string
    */
    func tempToString() -> String {
        return String(format: "%.2fº", temp)
    }
    
    /**
    * convert Humidity double to string
    */
    func humidityToString() -> String {
        return String(format: "%.2f%%", humidity)
    }
    
    /**
    * convert Pressure Int to string
    */
    func pressureToString() -> String {
        return "\(pressure)"
    }
    
    /**
    * format Date  to string
    */
    func timeToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY HH:mm:ss a"
        return dateFormatter.string(from: time)
    }
}
