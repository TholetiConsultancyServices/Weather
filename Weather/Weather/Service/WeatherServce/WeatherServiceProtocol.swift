//
//  WeatherServiceProtocol.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import Foundation
import CoreLocation

enum DownloadWeatherError {
    case urlError
    case networkRequestFailed
    case jsonSerializationFailed
    case jsonParsingFailed
}

enum DownloadWeatherResult {
    case Success(Weather)
    case Failure(DownloadWeatherError)
}

typealias WeatherCompletionHandler = (DownloadWeatherResult) -> Void

protocol WeatherServiceProtocol {
    /**
     This method is used to download the 5 day forecast for the given location
     - Parameter completionHandler: completion handler to notify the 5 day forecast information
     */
    func downloadWeatherInfo(for location: CLLocation,
                             completionHandler: @escaping WeatherCompletionHandler)
}
