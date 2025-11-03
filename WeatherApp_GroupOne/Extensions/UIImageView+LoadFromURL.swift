//
//  UIImageView+.swift
//  WeatherApp_GroupOne
//
//  Created by Natali Zhgenti on 02.11.25.
//


import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
