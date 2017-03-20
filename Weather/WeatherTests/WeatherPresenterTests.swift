//
//  WeatherPresenterTests.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import XCTest
import CoreLocation

@testable import Weather

class WeatherPresenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchWeatherInfo() {
        let weatherPresenter = WeatherPresenter(locationService: MockLocationService(),
                                                weatherService: MockWeatherService())
        
        XCTAssertNotNil(weatherPresenter)
        
        let promiseToCallBack = expectation(description: "calls back")
        weatherPresenter.fetchWeatherInfo { (result) in
            
            switch result {
                case .Success(let weatherViewModel):
                    XCTAssertNotNil(weatherViewModel)
                    XCTAssertTrue(weatherViewModel.title == "5 day forecast for London")
                case .Failed(_):
                    XCTFail("The result should be success")
                
            }
            promiseToCallBack.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            print("timed out: \(error)")
        }
    }
}
