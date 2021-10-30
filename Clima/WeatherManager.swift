//
//  WeatherManager.swift
//  Clima
//
//  Created by Aitor Trujillo on 27/9/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let api = "https://api.openweathermap.org/data/2.5/weather?&appid=bb88bc7f7c6ba910b6adfa84e2cf55d1&units=metric"
    
    func fetchWeatherByCity(cityName: String) {
        let urlString = "\(api)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeatherByCoordinates(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let urlString = "\(api)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
     
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            let task = URLSession(configuration: .default)
                .dataTask(with: url, completionHandler: {(data, response, error) in
                    if error != nil {
                        delegate?.didFailWithError(error!)
                        return
                    }
                    
                    if let safeData = data {
                        
                        do {
                            let weatherData = try JSONDecoder().decode(WeatherData.self, from: safeData)
                            let weather = WeatherModel(name: weatherData.name, conditionId: weatherData.weather[0].id, temp: weatherData.main.temp)
                            delegate?.didUpdateWeather(weather)
                        } catch {
                            delegate?.didFailWithError(error)
                        }
                    }
                    
                })
            
            task.resume()
        }
    }
}


