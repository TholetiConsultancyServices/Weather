//
//  LocationService.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import Foundation
import CoreLocation


class LocationService: NSObject,LocationServiceProtocol {
    
    fileprivate let locationManager = CLLocationManager()
    fileprivate var completionHandler: LocationServiceCompletionHandler?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
     func requestLocation(completionHandler: @escaping LocationServiceCompletionHandler) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            completionHandler?(LocationServiceResult.Success(location))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         completionHandler?(LocationServiceResult.Failure(error))
    }
}
