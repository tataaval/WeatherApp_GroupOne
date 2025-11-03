//
//  WeatherViewModel.swift
//  weather
//
//  Created by Natali Zhgenti on 02.11.25.
//

import Foundation

class WeatherViewModel: WeatherViewModelProtocol {
    
    //MARK: - Properties
    var weatherData: WeatherData?
    var onWeatherDataFetched: ((WeatherData) -> Void)?
    var onError: ((String) -> Void)?
    
    var weatherDetailsInCell: [WeatherDetailsInCell] = []
    var weatherDetailsInHeader: WeatherDetailsInHeader = WeatherDetailsInHeader(icon: "", city: "", temperature: "", description: "")
    
    var cityName: String { weatherData?.name ?? "" }
    
    var description: String { weatherData?.weather[0].description ?? "" }
    
    var icon: String { weatherData?.weather[0].icon  ?? "" }
    
    var realTemperature: Double { weatherData?.main.temp ?? 0}
    
    var feelsLike: Double { weatherData?.main.feels_like ?? 0 }
    
    var tempMin: Double { weatherData?.main.temp_min ?? 0}
    
    var tempMax: Double { weatherData?.main.temp_max ?? 0 }
    
    var humidity: Double { weatherData?.main.humidity ?? 0}
    
    var windSpeed: Double { weatherData?.wind.speed ?? 0}
    
    var windDirection: Double { weatherData?.wind.deg ?? 0 }
    
    var pressure: Double { weatherData?.main.pressure ?? 0}
    
    var sunrise: String {
        weatherData?.sys.sunrise.getDateStringFromUTC() ?? ""
    }
    
    var sunset: String {
        weatherData?.sys.sunset.getDateStringFromUTC() ?? ""
    }
    
    //TODO: countryname-ს ვაჩენ თუარა და თუ კი მთლიანს?
    var countryName: String {
        //weatherData?.sys.country ?? ""//.countryName(countryCode: weatherData.sys.country) ?? weatherData.sys.country
        weatherData?.sys.country.countryName(countryCode: weatherData?.sys.country ?? "") ?? ""
    }
    
    //MARK: - Methods
    func fetchData() {
        let url = API.currectWeather
        NetworkService.shared.getData(baseURL: url) {
            [weak self] (result: Result<WeatherData, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.weatherData = response
                    
                    self.weatherDetailsInCell = [
                        WeatherDetailsInCell(icon: "thermometer.medium", title: "Feels like", description: "\(self.feelsLike)°C"),
                        WeatherDetailsInCell(icon: "wind", title: "Wind", description: "\(self.windSpeed) m/s, \(self.windDirection)°"),
                        WeatherDetailsInCell(icon: "humidity", title: "Humidity", description: "\(self.humidity)%"),
                        WeatherDetailsInCell(icon: "gauge.with.dots.needle.50percent", title: "Pressure", description: "\(self.pressure) hPa"),
                        WeatherDetailsInCell(icon: "thermometer.low", title: "Today's Low", description: "\(self.tempMin)°C"),
                        WeatherDetailsInCell(icon: "thermometer.high", title: "Today's High", description: "\(self.tempMax)°C"),
                        WeatherDetailsInCell(icon: "sunrise", title: "Sunrise", description: "\(self.sunrise)"),
                        WeatherDetailsInCell(icon: "sunset", title: "Sunset", description: "\(self.sunset)"),
                    ]
                    
                    self.weatherDetailsInHeader = WeatherDetailsInHeader(
                        icon: "https://openweathermap.org/img/wn/\(self.icon)@2x.png",
                        //city: self.cityName,
                        city: "\(self.cityName), \(self.countryName)",
                        temperature: "\(self.realTemperature)°C",
                        description: self.description
                    )
                    
                    self.onWeatherDataFetched?(response)
                    
                case .failure(let error):
                    self.onError?("სცადეთ მოგვიანებით")
                    print("დაფიქსირდა შეცდომა: \(error.localizedDescription)")
                }
            }
        }
    }
}
