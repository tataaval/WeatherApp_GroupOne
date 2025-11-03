//
//  AppCoordinatorProtocol.swift
//  WeatherApp_GroupOne
//
//  Created by Natali Zhgenti on 03.11.25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    //var childCoordinators: [Coordinator] { get set }
    func start()
}
