//
//  SpinDanceCodeChallengeTests.swift
//  SpinDanceCodeChallengeTests
//
//  Created by Robert Hartman on 2/13/20.
//  Copyright © 2020 SpinDance. All rights reserved.
//

import XCTest
@testable import SpinDanceCodeChallenge

class SpinDanceCodeChallengeTests: XCTestCase {
    
    //var sut: SensorViewModel!

    override func setUp() {
        //sut = SensorViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSensorViewModelReading() {
        
        //given
        let date = Date()
        let sut = SensorViewModelReading(temp: 0.5, humidity: 0.06, pressure: 90, time: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY HH:mm:ss a"
        
        //when
        let strTemp = sut.tempToString()
        let strHumidity = sut.humidityToString()
        let strPressure = sut.pressureToString()
        let strDate = sut.timeToString()
        
        //then
        XCTAssertEqual(strTemp, "0.50º")
        XCTAssertEqual(strHumidity, "0.06%")
        XCTAssertEqual(strPressure, "90")
        XCTAssertEqual(strDate, dateFormatter.string(from: date))
    }
}
