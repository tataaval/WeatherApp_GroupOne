//
//  FavoritesViewModel.swift
//  WeatherApp_GroupOne
//
//  Created by m1 pro on 03.11.25.
//

import Foundation

final class FavoritesViewModel {
    var onFavoritesUpdate: (([String]) -> Void)?
    
    func loadFavorites() {
       let favorites = FavoritesManager.shared.getFavorites()
       onFavoritesUpdate?(favorites)
   }
}
