//
//  Untitled.swift
//  WeatherApp_GroupOne
//
//  Created by Natali Zhgenti on 02.11.25.
//

import Foundation

extension Int {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = .current

        return dateFormatter.string(from: date)
    }
}
