//
//  WeatherViewModelTests.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testWeatherViewModel() {
        guard let weatherJSON = TestUtils().loadData(fromFileName: "weather_forecast") else {
            print("cannot load test file")
            return
        }
        let weather = Weather(JSON: weatherJSON)
        let weatherViewModel = WeatherViewModel(model: weather!)
        XCTAssertNotNil(weatherViewModel)
        XCTAssertTrue(weatherViewModel.title == "5 day forecast for London")
        XCTAssertTrue(weatherViewModel.dailyForecasts.count == 6)
        
        let dailyForecast = weatherViewModel.dailyForecasts.first
        XCTAssertNotNil(dailyForecast)
        XCTAssertTrue(dailyForecast?.day == "Saturday, March 18, 2017")
        XCTAssertTrue(dailyForecast?.forecasts.count == 1)
        
        let forecast = dailyForecast?.forecasts.first
        XCTAssertNotNil(forecast)
        XCTAssertTrue(forecast?.time == "9:00 PM")
        XCTAssertTrue(forecast?.forecastCondition == "light rain")
         XCTAssertTrue(forecast?.temperature == "12.0 °C")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
