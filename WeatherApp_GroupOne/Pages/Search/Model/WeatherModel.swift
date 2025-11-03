//
//  WeatherModel.swift
//  WeatherApp_GroupOne
//
//  Created by Temo Pestvenidze on 02.11.25.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: ForecastMain
    let weather: [ForecastWeather]
}



