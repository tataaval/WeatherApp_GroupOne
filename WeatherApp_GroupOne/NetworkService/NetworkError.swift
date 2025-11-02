//
//  NetworkError.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 02.11.25.
//


import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case noData

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL არასწორია"
        case .invalidResponse:
            return "სერვერის პასუხი არასწორია."
        case .invalidStatusCode:
            return "არასწორი სტატუს კოდი"
        case .noData:
            return "No data ერორი"
        }
    }
}
