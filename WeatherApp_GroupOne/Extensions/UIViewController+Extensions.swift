//
//  UIViewController+Extensions.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 02.11.25.
//

import UIKit

extension UIViewController {
    func setBackgroundImage(_ imageName: String, contentMode: UIView.ContentMode = .scaleAspectFill) {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.clipsToBounds = true

        view.insertSubview(backgroundImageView, at: 0)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
