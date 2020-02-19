//
//  SensorReader.swift
//  SpinDanceCodeChallenge
//
//  Created by Robert Hartman on 2/13/20.
//  Copyright © 2020 SpinDance. All rights reserved.
//

import Foundation
import RxSwift

/**
* A singleton that handles generating random weather sensor readings
*/
class SensorReader {
    static let shared = SensorReader()

    private init() { }
    private var timer: Timer?

    /**
     * The interval which weather sensor readings are generated
     */
    var readerInterval: TimeInterval = 1 {
        didSet {
            guard oldValue != readerInterval else { return }

            // If we were reporting, restart.
            if timer != nil {
                startSensorReadings()
            }
        }
    }

    let sensorReadingsSubject = PublishSubject<SensorReading>()

    /**
     * Starts the indefinite generation of weather sensor readings
     */
    func startSensorReadings() {
        stopSensorReadings()

        timer = Timer.scheduledTimer(withTimeInterval: readerInterval, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.sensorReadingsSubject.onNext(self.generateSensorReadings())
        }
    }

    /**
     * Stop the generation of weather sensor readings
     */
    func stopSensorReadings() {
        timer?.invalidate()
        timer = nil
    }

    private func generateSensorReadings() -> SensorReading {
        let temp = Double.random(in: 0...100)
        let humidity = Double.random(in: 0...1)
        let pressure = Int.random(in: 95...105)
        return SensorReading(temp: temp, humidity: humidity, pressure: pressure, time: Date())
    }
}
