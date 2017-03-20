//
//  LocationServiceProtocol.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import Foundation
import CoreLocation


enum LocationServiceResult {
    case Success(CLLocation)
    case Failure(Error)
}

typealias LocationServiceCompletionHandler = (LocationServiceResult) -> Void

protocol LocationServiceProtocol {
    /**
     This method is used to find the current location of the device
     - Parameter completionHandler: completion handler to notify about the status of the current location
     */
    func requestLocation(completionHandler: @escaping LocationServiceCompletionHandler)
}
