//
//  FavoritesDetailsViewModel.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 04.11.25.
//

import Foundation

class FavoritesDetailsViewModel {

    // MARK: - Properties
    let cityName: String

    var onWeatherUpdate: ((WeatherResponse) -> Void)?
    var onError: ((String) -> Void)?
    var updateFavoriteButton: ((Bool) -> Void)?

    // MARK: - Init
    init(cityName: String) {
        self.cityName = cityName
    }

    // MARK: - Network
    func fetchWeather() {
        let url = API.searchForecast(for: cityName)

        NetworkService.shared.getData(baseURL: url) {
            (result: Result<WeatherResponse, Error>) in
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

    // MARK: - Favorites Logic
    func toggleFavorite() {
        FavoritesManager.shared.toggleFavorite(city: cityName)
        let isFavorite = FavoritesManager.shared.isFavorite(city: cityName)
        updateFavoriteButton?(isFavorite)
    }

    func checkIfFavorite() {
        let isFavorite = FavoritesManager.shared.isFavorite(city: cityName)
        updateFavoriteButton?(isFavorite)
    }
}
