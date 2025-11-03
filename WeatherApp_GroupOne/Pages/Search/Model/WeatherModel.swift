//
//  WeatherModel.swift
//  WeatherApp_GroupOne
//
//  Created by Temo Pestvenidze on 02.11.25.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
    let pressure: Int
}

struct Weather: Decodable {
    let description: String
    let icon: String
}


