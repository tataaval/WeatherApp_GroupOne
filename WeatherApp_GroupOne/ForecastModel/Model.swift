import Foundation

struct ForecastResponse: Decodable {
    let list: [WeatherItem]
}

struct WeatherItem: Decodable {
    let dt: TimeInterval
    let main: Main
    let weather: [Weather]
    let dt_txt: String
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
}
