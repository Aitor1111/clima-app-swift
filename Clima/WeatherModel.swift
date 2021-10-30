//
//  WeatherModel.swift
//  Clima
//
//  Created by Aitor Trujillo on 27/9/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let name: String
    let conditionId: Int
    let temp: Double
    
    var tempFormat: String {
        return String(format: "%.1f", temp)
    }
    
    var conditionIcon: String {
            switch conditionId {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 700...781:
                    return "cloud.fog"
                case 800:
                    return "sun.min"
                case 800...804:
                    return "cloud"
                
                default:
                    return "sun.min"
            }
    }
}
