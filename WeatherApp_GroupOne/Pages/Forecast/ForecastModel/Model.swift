import Foundation

struct ForecastResponse: Decodable {
    let list: [ForecastWeatherItem]
}

struct ForecastWeatherItem: Decodable {
    let dt: TimeInterval
    let main: ForecastMain
    let weather: [ForecastWeather]
    let dt_txt: String
}

struct ForecastMain: Decodable {
    let temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
    var sea_level: Double
    var grnd_level: Double
}

struct ForecastWeather: Decodable {
    let main: String
    let description: String
    let icon: String
}
