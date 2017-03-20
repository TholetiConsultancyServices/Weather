//
//  WeatherService.swift
//  Weather
//
//  Created by Appaji Tholeti on 20/03/2017.
//  Copyright © 2017 Tholeti Consultancy Ltd. All rights reserved.
//

import Foundation
import CoreLocation
import ObjectMapper
import ReachabilitySwift

struct WeatherService: WeatherServiceProtocol {
     let urlPath = "http://api.openweathermap.org/data/2.5/forecast"
    let appId = "1067a378382f990628da399954d5ddcd"
    
    func downloadWeatherInfo(for location: CLLocation,
                             completionHandler: @escaping WeatherCompletionHandler) {
        
        let reachability = Reachability()
        guard reachability?.isReachable == true else {
            completionHandler(DownloadWeatherResult.Failure(.networkRequestFailed))
            return
        }
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        guard let url = requestURL(for: location) else {
            completionHandler(DownloadWeatherResult.Failure(.urlError))
            return
        }
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request,
                                    completionHandler: { data, response, networkError in
                                        
            // Check network error
            guard networkError == nil else {
                completionHandler(DownloadWeatherResult.Failure(.networkRequestFailed))
                return
            }
            
            // Check JSON serialization error
            guard let unwrappedData = data else {
                completionHandler(DownloadWeatherResult.Failure(.jsonSerializationFailed))
                return
            }
                                        
            do {
                if let JSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? [String: Any] {
                    guard let weather = Weather(JSON: JSON) else {
                        completionHandler(DownloadWeatherResult.Failure(.jsonSerializationFailed))
                        return
                    }
                    
                    completionHandler(DownloadWeatherResult.Success(weather))
                }
                } catch {
                    completionHandler(DownloadWeatherResult.Failure(.jsonSerializationFailed))
            }
                                        
   
        })
        
        task.resume()
    }
    
    private func requestURL(for location: CLLocation) -> URL? {
        guard var components = URLComponents(string:urlPath) else {
            return nil
        }
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        components.queryItems = [URLQueryItem(name:"lat", value:latitude),
                                 URLQueryItem(name:"lon", value:longitude),
                                 URLQueryItem(name:"appid", value:appId)]
        
        return components.url
    }
}

