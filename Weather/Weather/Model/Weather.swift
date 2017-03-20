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
    var date:Date?
    var temperature: Double?
    var weatherConditionId: Int?
    var weatherConditionIcon: String?
    var weatherDescription: String?
    
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
    var cityName: String?
    var forecasts: [Forecast]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        cityName     <- map["city.name"]
        forecasts  <- map["list"]
    }
}
