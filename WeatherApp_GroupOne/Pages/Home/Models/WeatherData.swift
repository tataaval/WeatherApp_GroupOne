//
//  WeatherModel.swift
//  weather
//
//  Created by Natali Zhgenti on 02.11.25.
//

import UIKit

struct WeatherData: Decodable {
    var weather: [Weather]
    var main: Main
    var wind: Wind
    var sys: Sys
    var name: String
}

struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
    var sea_level: Double
    var grnd_level: Double
}

struct Wind: Decodable {
    var speed: Double
    var deg: Double
    var gust: Double
}

struct Sys: Decodable {
    var country: String
    var sunrise: Int
    var sunset: Int
}
