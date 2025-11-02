//
//  WeatherViewModel.swift
//  weather
//
//  Created by Natali Zhgenti on 02.11.25.
//

import Foundation

class WeatherViewModel {
    
    //MARK: - Properties
    let weatherData: WeatherData
    
    var cityName: String { weatherData.name }
    
    var description: String { weatherData.weather[0].description }
    
    var icon: String { weatherData.weather[0].icon }
    
    var realTemperature: Double { weatherData.main.temp }
    
    var feelsLike: Double { weatherData.main.feels_like }
    
    var tempMin: Double { weatherData.main.temp_min }
    
    var tempMax: Double { weatherData.main.temp_max }
    
    var humidity: Double { weatherData.main.humidity }
    
    var windSpeed: Double { weatherData.wind.speed }
    
    var windDirection: Double { weatherData.wind.deg }
    
    var pressure: Double { weatherData.main.pressure }
    
    var sunrise: String {
        weatherData.sys.sunrise.getDateStringFromUTC()
    }
    
    var sunset: String {
        weatherData.sys.sunset.getDateStringFromUTC()
    }
    
    // 
    var countryName: String {
        weatherData.sys.country//.countryName(countryCode: weatherData.sys.country) ?? weatherData.sys.country
    }
    
    //MARK: - Init
    init(weatherData: WeatherData) {
        self.weatherData = weatherData
    }
}
