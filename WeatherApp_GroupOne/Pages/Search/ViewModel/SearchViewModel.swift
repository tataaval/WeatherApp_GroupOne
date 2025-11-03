//
//  SearchViewModel.swift
//  WeatherApp_GroupOne
//
//  Created by Temo Pestvenidze on 02.11.25.
//

import Foundation

final class SearchViewModel {
    var onWeatherUpdate: ((WeatherResponse) -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchWeather(for city: String) {
        let url = API.searchForecast(for: city)
        
        NetworkService.shared.getData(baseURL: url) { (result: Result<WeatherResponse, Error>) -> (Void) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.onWeatherUpdate?(response)
                case .failure(let error):
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }
}
