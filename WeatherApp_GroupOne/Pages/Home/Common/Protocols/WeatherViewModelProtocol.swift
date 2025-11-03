//
//  WeatherViewModelProtocol.swift
//  WeatherApp_GroupOne
//
//  Created by Natali Zhgenti on 03.11.25.
//

protocol WeatherViewModelProtocol {
    var weatherData: WeatherData? { get }
    var onWeatherDataFetched: ((WeatherData) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    func fetchData()
}
