//
//  MockLocationService.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import Foundation
import CoreLocation

@testable import Weather


class MockLocationService: LocationServiceProtocol {
    func requestLocation(completionHandler: @escaping LocationServiceCompletionHandler) {
        DispatchQueue.main.async {
            let location = CLLocation(latitude: 51.5074, longitude: 0.1278)
            completionHandler(LocationServiceResult.Success(location))
        }
    }
}
