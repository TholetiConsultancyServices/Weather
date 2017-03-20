//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import Foundation
import CoreLocation

struct FetchWeatherInfoError{
    static let locationError = "We're having trouble finding the location"
    static let serverError   = "The weather service is not working."
    static let networkError  = "The network appears to be down."
    static let dataError     = "We're having trouble processing weather data."
}

enum FetchWeatherInfoResult {
    case Success(WeatherViewModel)
    case Failed(String)
}

typealias FetchWeatherInfoCompletionHandler = (FetchWeatherInfoResult) -> Void

class WeatherPresenter {
    
    private var locationService: LocationServiceProtocol
    fileprivate var weatherService: WeatherServiceProtocol
    fileprivate var completionHandler: FetchWeatherInfoCompletionHandler?
    fileprivate var currentLocation: CLLocation?
    
    init(locationService: LocationServiceProtocol, weatherService: WeatherServiceProtocol) {
        self.locationService = locationService
        self.weatherService = weatherService
    }
    
    func fetchWeatherInfo(completionHandler: @escaping FetchWeatherInfoCompletionHandler) {
        self.completionHandler = completionHandler
        guard let currentLocation = currentLocation else {
            findCurrentLocation()
            return
        }
        
        fetchWeatherInfo(for: currentLocation)
    }
    
    private func findCurrentLocation() {
        locationService.requestLocation(completionHandler: {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .Success(let location):
                strongSelf.currentLocation = location
                strongSelf.fetchWeatherInfo(for: location)
            case .Failure(_):
                strongSelf.completionHandler?(FetchWeatherInfoResult.Failed(FetchWeatherInfoError.locationError))
            }
        })

    }
    
    fileprivate func fetchWeatherInfo(for currentLocation: CLLocation) {
        weatherService.downloadWeatherInfo(for: currentLocation) { [weak self] result in
            guard let strongSelf = self else {
                return
            }

            DispatchQueue.main.async {
                switch(result) {
                case .Success(let weather):
                    strongSelf.completionHandler?(FetchWeatherInfoResult.Success(WeatherViewModel(model: weather)))
                case .Failure(let error):
                    var errorDescripton:String = String()
                    switch error {
                        case .urlError: errorDescripton = FetchWeatherInfoError.serverError
                        case .networkRequestFailed: errorDescripton = FetchWeatherInfoError.networkError
                        case .jsonSerializationFailed, .jsonParsingFailed: errorDescripton = FetchWeatherInfoError.dataError
                    }
                    strongSelf.completionHandler?(FetchWeatherInfoResult.Failed(errorDescripton))
                }
            }
        }
    }
}
