//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
       }
    
    func testWeatherModel() {
        guard let weatherJSON = TestUtils().loadData(fromFileName: "weather_forecast") else {
            print("cannot load test file")
            return
        }
        
        let weather = Weather(JSON: weatherJSON)
        XCTAssertNotNil(weather)
        XCTAssertTrue(weather?.cityName == "London")
        XCTAssertTrue(weather?.forecasts?.count == 40)
        
        let forecast = weather?.forecasts?.first
        XCTAssertNotNil(forecast)
        XCTAssertTrue(forecast?.temperature == 285)
        XCTAssertTrue(forecast?.weatherConditionId == 500)
        XCTAssertTrue(forecast?.weatherDescription == "light rain")
        XCTAssertTrue(forecast?.weatherConditionIcon == "10n")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
