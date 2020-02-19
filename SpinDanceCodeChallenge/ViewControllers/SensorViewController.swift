//
//  SensorViewController.swift
//  SpinDanceCodeChallenge
//
//  Created by Raul Mantilla on 16/02/20.
//  Copyright © 2020 SpinDance. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class SensorViewController: UIViewController {
    
    /**
    * Set the background color for sensor
    */
    @IBOutlet var bgSensor: UIView! {
        didSet {
            bgSensor.backgroundColor = .lightGray
            bgSensor.layer.cornerRadius = 10.0
            bgSensor.layer.borderColor = UIColor.darkGray.cgColor
            bgSensor.layer.borderWidth = 2.0
        }
    }
    
    @IBOutlet var bgReportTemp: UIView! {
        didSet {
            bgReportTemp.backgroundColor = .lightGray
            bgReportTemp.layer.cornerRadius = 10.0
            bgReportTemp.layer.borderColor = UIColor.darkGray.cgColor
            bgReportTemp.layer.borderWidth = 2.0
        }
    }
    
    @IBOutlet var bgReportHumidity: UIView! {
        didSet {
            bgReportHumidity.backgroundColor = .lightGray
            bgReportHumidity.layer.cornerRadius = 10.0
            bgReportHumidity.layer.borderColor = UIColor.darkGray.cgColor
            bgReportHumidity.layer.borderWidth = 2.0
        }
    }
    
    @IBOutlet var bgReportPressure: UIView! {
        didSet {
            bgReportPressure.backgroundColor = .lightGray
            bgReportPressure.layer.cornerRadius = 10.0
            bgReportPressure.layer.borderColor = UIColor.darkGray.cgColor
            bgReportPressure.layer.borderWidth = 2.0
        }
    }
    
    @IBOutlet var lbSensorTemp: UILabel!
    @IBOutlet var lbSensorHumidity: UILabel!
    @IBOutlet var lbSensorPressure: UILabel!
    @IBOutlet var lbSensorTime: UILabel!
    
    @IBOutlet var slSensorFrequency: UISlider!
    @IBOutlet var lbSensorFrequency: UILabel!
    
    @IBOutlet var slReportFrequency: UISlider!
    @IBOutlet var lbReportFrequency: UILabel!
    
    @IBOutlet var slReportInterval: UISlider!
    @IBOutlet var lbReportInterval: UILabel!
    
    let viewModel = SensorViewModel()
    var disposeBag = DisposeBag()
    
    //Report Outlets
    @IBOutlet var lbSensorMinTemp: UILabel!
    @IBOutlet var lbSensorMaxTemp: UILabel!
    @IBOutlet var lbSensorAvgTemp: UILabel!
    
    @IBOutlet var lbSensorMinHumidity: UILabel!
    @IBOutlet var lbSensorMaxHumidity: UILabel!
    @IBOutlet var lbSensorAvgHumidity: UILabel!
    
    @IBOutlet var lbSensorMinPressure: UILabel!
    @IBOutlet var lbSensorMaxPressure: UILabel!
    @IBOutlet var lbSensorAvgPressure: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    /**
     Bind the view model
    */
    func bind() {
        viewModel.sensorReadingsSubject.subscribe(onNext: { [weak self] viewModelReading in
            guard let self = self  else { return }
            self.lbSensorTemp.text = viewModelReading.tempToString()
            self.lbSensorHumidity.text = viewModelReading.humidityToString()
            self.lbSensorPressure.text = viewModelReading.pressureToString()
            self.lbSensorTime.text = viewModelReading.timeToString()
        })
            .disposed(by: disposeBag)
        
        slSensorFrequency.rx.value
            .subscribe(onNext: { [weak self] (value) in
                guard let self = self  else { return }
                let intValue = Int(value)
                self.viewModel.setReadingFrequency(value: intValue)
                self.lbSensorFrequency.text = "\(intValue)"
            })
            .disposed(by: disposeBag)
        
        viewModel.sensorReportSubject.subscribe(onNext: { [weak self] report in
            guard let self = self  else { return }
            
            self.lbSensorMinTemp.text = report.tempToString(report.minTemp)
            self.lbSensorMaxTemp.text = report.tempToString(report.maxTemp)
            self.lbSensorAvgTemp.text = report.tempToString(report.avgTemp)
            
            self.lbSensorMinHumidity.text = report.humidityToString(report.minHumidity)
            self.lbSensorMaxHumidity.text = report.humidityToString(report.maxHumidity)
            self.lbSensorAvgHumidity.text = report.humidityToString(report.avgHumidity)
            
            self.lbSensorMinPressure.text = report.pressureToString(report.minPressure)
            self.lbSensorMaxPressure.text = report.pressureToString(report.maxPressure)
            self.lbSensorAvgPressure.text = report.pressureToString(report.avgPressure)
        })
        .disposed(by: disposeBag)
        
        slReportFrequency.rx.value
        .subscribe(onNext: { [weak self] (value) in
            guard let self = self  else { return }
            let intValue = Int(value)
            self.viewModel.setReportFrequency(value: intValue)
            self.lbReportFrequency.text = "\(intValue)"
        })
        .disposed(by: disposeBag)
        
        slReportInterval.rx.value
        .subscribe(onNext: { [weak self] (value) in
            guard let self = self  else { return }
            let intValue = Int(value)
            self.viewModel.setReportInterval(value: intValue)
            self.lbReportInterval.text = "\(intValue)"
        })
        .disposed(by: disposeBag)
    }
}

