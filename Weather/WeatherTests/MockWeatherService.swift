//
//  MockWeatherService.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import Foundation
import CoreLocation

@testable import Weather

class MockWeatherService: WeatherServiceProtocol {
    func downloadWeatherInfo(for location: CLLocation,
                             completionHandler: @escaping WeatherCompletionHandler) {
        DispatchQueue.main.async {
            guard let weatherJSON = TestUtils().loadData(fromFileName: "weather_forecast") else {
                completionHandler(DownloadWeatherResult.Failure(.urlError))
                return
            }
            let weather = Weather(JSON: weatherJSON)
            completionHandler(DownloadWeatherResult.Success(weather!))
        }
    }
}
