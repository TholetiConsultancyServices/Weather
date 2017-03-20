//
//  AppConfiguration.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import Foundation
import UIKit

struct AppConfiguration {
    /**
     This method configures the required components ans injects usng dependenct injection
     - Parameter window: window object of the application.
     */
    static func configure(window: UIWindow?) {
        let navigationController = window?.rootViewController as? UINavigationController
        guard let weatherViewController = navigationController?.topViewController as? WeatherViewController else {
            return
        }
        let presenter = WeatherPresenter(locationService: LocationService(),
                                         weatherService: WeatherService())
        weatherViewController.presenter = presenter
    }
}
