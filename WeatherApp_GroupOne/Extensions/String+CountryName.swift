//
//  String+CountryName.swift
//  WeatherApp_GroupOne
//
//  Created by Natali Zhgenti on 02.11.25.
//

import Foundation

extension String {
    func countryName(countryCode: String) -> String? {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: countryCode)
    }
}
