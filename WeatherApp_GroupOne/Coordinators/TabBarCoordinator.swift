//
//  TabBarCoordinator.swift
//  WeatherApp_GroupOne
//
//  Created by Natali Zhgenti on 03.11.25.
//
import UIKit

class TabBarCoordinator: Coordinator {
    //MARK: - Properties
    //var childCoordinators = [Coordinator]()
    internal var navigationController: UINavigationController
    
    //MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Methods
    func start() {
        let tabBarController = UITabBarController()
        
        let homeViewModel = WeatherViewModel()
        let homeVC = HomeViewController(viewModel: homeViewModel, coordinator: self)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let forecastViewModel = ForecastViewModel()
        let forecastVC = ForecastViewController(viewModel: forecastViewModel)
        forecastVC.tabBarItem = UITabBarItem(title: "Forecast", image: UIImage(systemName: "cloud.sun"), tag: 1)
        
        let searchViewModel = SearchViewModel()
        let searchVC = SearchViewController(viewModel: searchViewModel)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        let favoritesViewModel = FavoritesViewModel()
        let favoritesVC = FavoritesViewController(viewModel: favoritesViewModel)
        favoritesVC.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "bookmark"), tag: 3)
        
        let aiAssistantViewModel = AIAssistantViewModel()
        let aiAssistantVC = AIAssistantViewController(viewModel: aiAssistantViewModel)
        aiAssistantVC.tabBarItem = UITabBarItem(title: "Assistant", image: UIImage(systemName: "message.badge.waveform"), tag: 4)
        
        tabBarController.viewControllers = [homeVC, forecastVC, searchVC, favoritesVC, aiAssistantVC]
        navigationController.viewControllers = [tabBarController]
    }
}
