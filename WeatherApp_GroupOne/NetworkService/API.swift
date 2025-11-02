//
//  API.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 02.11.25.
//

struct API {
    private static let apiKey = "eda9b39a8f8b30c8f5eddbf6f47013f0"
    private static let baseURL = "https://api.openweathermap.org/data/2.5/"
    private static let lat: Double = 41.99
    private static let lon: Double = 43.1234
    
    static let currectWeather = "\(baseURL)weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
    static let forecast = "\(baseURL)/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
    
    static func searchForecast(for location: String) -> String {
        "\(baseURL)/weather?q=\(location)&appid=\(apiKey)&units=metric"
    }
}
