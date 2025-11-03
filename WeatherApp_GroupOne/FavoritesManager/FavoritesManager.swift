//
//  FavoritesManager.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 03.11.25.
//

import Foundation

class FavoritesManager {
    static var shared: FavoritesManager = FavoritesManager()
    private let favoritesKey: String = "favorites"
    private init() {}
    
    func getFavorites() -> [String] {
        UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
    }
    
    private func add(city: String) {
        var favorites: [String] = getFavorites()
        
        if !favorites.contains(city) {
            favorites.append(city)
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
        }
    }
    
    private func remove(city: String) {
        var favorites: [String] = getFavorites()
        
        favorites.removeAll { $0 == city }
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }
    
    func isFavorite(city: String) -> Bool {
        getFavorites().contains(city)
    }
    
    func toggleFavorite(city: String) {
        isFavorite(city: city) ? remove(city: city) : add(city: city)
    }
}
