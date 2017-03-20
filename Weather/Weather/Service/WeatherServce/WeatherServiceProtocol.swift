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
    func downloadWeatherInfo(for location: CLLocation,
                             completionHandler: @escaping WeatherCompletionHandler)
}
