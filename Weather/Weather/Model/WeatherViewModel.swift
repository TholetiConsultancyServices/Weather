//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import Foundation

struct ForecastViewModel {
    private(set) var time: String = String()
    private(set) var forecastCondition: String = String()
    private(set) var forecastIcon: String = String()
    private(set) var temperature: String = String()
    
    private static let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    init(model: Forecast) {
        if let date = model.date  {
            time = ForecastViewModel.formatter.string(from: date)
        }
        if let weatherDescription = model.weatherDescription {
            forecastCondition = weatherDescription
        }
        if let temperature = model.temperature {
            self.temperature = "\(round(temperature - 273.15)) \u{00B0}C"
        }
        
        if let  weatherConditionId = model.weatherConditionId,
            let weatherIcon = model.weatherConditionIcon {
            forecastIcon = WeatherIcon(condition: weatherConditionId, iconString: weatherIcon).iconText
        }
    }
}

struct WeatherDailyForecast {
    let dayIdentifier: Date
    let forecasts: [ForecastViewModel]
    let day: String

}

struct WeatherViewModel {
    
    var title: String = String()
    var dailyForecasts:[WeatherDailyForecast] = []
    
    init(model: Weather) {
        if let cityName = model.cityName {
            self.title = "5 day forecast for \(cityName)"
        }
        self.dailyForecasts = prepareDailyForecast(from: model.forecasts)
    }
    
    private func prepareDailyForecast(from forecasts:[Forecast]?) -> [WeatherDailyForecast] {
        
        guard let forecasts = forecasts else {
            return []
        }
        
        // Group all forecasts into days
        let calendar = NSCalendar.current
        var grouped: [Date: [Forecast]] = [:]
        for forecast in forecasts {
            guard let forecastDate = forecast.date else {
                continue
            }
            // Get day identifier
            let comps = calendar.dateComponents([.year,.month,.day], from: forecastDate)
            guard let dayIdentifier = calendar.date(from: comps) else {
                continue
            }
            // Add to grouped
            var forecasts = grouped[dayIdentifier] ?? [Forecast]()
            forecasts.append(forecast)
            grouped[dayIdentifier] = forecasts
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        // Create daily forecast objects
        var dailyForecasts: [WeatherDailyForecast] = []
        for (dayIdentifier, forecasts) in grouped {
            let sortedForecasts = forecasts.sorted { $0.date! < $1.date! }
            let forecastViewModels = sortedForecasts.map {ForecastViewModel(model: $0)}
            
            let day = dateFormatter.string(from: dayIdentifier)
            let dailyForecast = WeatherDailyForecast(dayIdentifier: dayIdentifier,
                                                     forecasts: forecastViewModels,
                                                     day: day)
            dailyForecasts.append(dailyForecast)
        }
        
        // Return sorted daily forecasts
        return dailyForecasts.sorted { $0.dayIdentifier < $1.dayIdentifier }
    }
    
}
