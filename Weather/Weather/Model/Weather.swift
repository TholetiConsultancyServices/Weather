//
//  Forecast.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

struct Forecast: Mappable {
    private(set) var date:Date?
    private(set) var temperature: Double?
    private(set) var weatherConditionId: Int?
    private(set) var weatherConditionIcon: String?
    private(set) var weatherDescription: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        date <- (map["dt"],DateTransform())
        temperature   <- map["main.temp"]
        weatherConditionId   <- map["weather.0.id"]
        weatherConditionIcon <- map["weather.0.icon"]
        weatherDescription   <- map["weather.0.description"]
    }
}

struct Weather: Mappable {
    private(set) var cityName: String?
    private(set) var forecasts: [Forecast]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        cityName     <- map["city.name"]
        forecasts  <- map["list"]
    }
}
