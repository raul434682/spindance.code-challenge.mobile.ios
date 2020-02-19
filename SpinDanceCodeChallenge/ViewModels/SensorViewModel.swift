//
//  SensorViewModel.swift
//  SpinDanceCodeChallenge
//
//  Created by Raul Mantilla on 16/02/20.
//  Copyright © 2020 SpinDance. All rights reserved.
//

import Foundation
import RxSwift

class SensorViewModel {
    
    let sensor = SensorReader.shared
    let sensorReadingsSubject = PublishSubject<SensorViewModelReading>()
    let sensorReportSubject = PublishSubject<SensorReport>()
    var disposeBag = DisposeBag()
    var sensorRecords: [SensorReading] = []
    
    private var timer: Timer?

    /**
     * The interval which weather sensor report are generated
     */
    var reportInterval: TimeInterval = 1 {
        didSet {
            guard oldValue != reportInterval else { return }

            // If we were reporting, restart.
            if timer != nil {
                startSensorReport()
            }
        }
    }
    var range = 5
    
    init() {
        bind()
        sensor.startSensorReadings()
        startSensorReport()
    }
    
    /**
    * bind to sensor.
    */
    func bind() {
        sensor.sensorReadingsSubject.subscribe(onNext: { [weak self] reading in
            guard let self = self  else { return }
            let viewModelReading = SensorViewModelReading(temp: reading.temp, humidity: reading.humidity, pressure: reading.pressure, time: reading.time)
            self.addSensorRecords(data: reading)
            self.sensorReadingsSubject.onNext(viewModelReading)
        })
        .disposed(by: disposeBag)
    }
    
    /**
    * Starts  the generation of weather sensor report
    */
    func startSensorReport() {
        stopSensorReport()

        timer = Timer.scheduledTimer(withTimeInterval: reportInterval, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.sensorReportSubject.onNext(self.generateSensorReport())
        }
    }
    /**
     * Stop the generation of weather sensor report
     */
    func stopSensorReport() {
        timer?.invalidate()
        timer = nil
    }
    
    /**
    * Add data history, maximun 10 records
    */
    func addSensorRecords(data: SensorReading) {
        sensorRecords.append(data)
        if sensorRecords.count > 10 {
            sensorRecords.remove(at: 0)
        }
    }
    
    func setReadingFrequency(value: Int) {
        sensor.readerInterval = TimeInterval(value)
        sensor.startSensorReadings()
    }
    
    func setReportFrequency(value: Int) {
        reportInterval = TimeInterval(value)
        startSensorReport()
    }
    
    func setReportInterval(value: Int) {
        range = value
    }
    
    /**
    * Generates the report data
    */
    func generateSensorReport() -> SensorReport  {
        let recordsCount = sensorRecords.count
        
        guard recordsCount >= 2 else {
            return SensorReport(minTemp: 0, maxTemp: 0, avgTemp: 0, minHumidity: 0, maxHumidity: 0, avgHumidity: 0, minPressure: 0, maxPressure: 0, avgPressure: 0)
        }
        
        let maxRange = min(range,recordsCount-1)
        let sensorRecordsInRange = sensorRecords[0...maxRange]
        
        let minTemp = sensorRecordsInRange.sorted(by: { $0.temp < $1.temp }).first?.temp ?? 0
        let maxTemp = sensorRecordsInRange.sorted(by: { $0.temp > $1.temp }).first?.temp ?? 0
        var avgTemp = 0
        if !sensorRecords.isEmpty {
            let avgTempArray = sensorRecordsInRange.map{$0.temp}
            avgTemp = (Int(avgTempArray.reduce(0,+)) / recordsCount)
        }
        
        let minHumidity = sensorRecordsInRange.sorted(by: { $0.humidity < $1.humidity }).first?.humidity ?? 0
        let maxHumidity = sensorRecordsInRange.sorted(by: { $0.humidity > $1.humidity }).first?.humidity ?? 0
        var avgHumidity = 0
        if !sensorRecords.isEmpty {
            let avgHumidityArray = sensorRecordsInRange.map{$0.humidity}
            avgHumidity = (Int(avgHumidityArray.reduce(0,+)) / recordsCount)
        }
        
        let minPressure = sensorRecordsInRange.sorted(by: { $0.pressure < $1.pressure }).first?.pressure ?? 0
        let maxPressure = sensorRecordsInRange.sorted(by: { $0.pressure > $1.pressure }).first?.pressure ?? 0
        var avgPressure = 0
        if !sensorRecords.isEmpty {
            let avgPressureArray = sensorRecordsInRange.map{$0.pressure}
            avgPressure = (avgPressureArray.reduce(0,+) / recordsCount)
        }
        
        return SensorReport(minTemp: minTemp, maxTemp: maxTemp, avgTemp: Double(avgTemp), minHumidity: minHumidity, maxHumidity: maxHumidity, avgHumidity: Double(avgHumidity), minPressure: minPressure, maxPressure: maxPressure, avgPressure: avgPressure)
    }
}

