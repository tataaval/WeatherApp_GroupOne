import Foundation

protocol ForecastViewModelProtocol: AnyObject {
    func reloadData()
}

class ForecastViewModel {
    
    private(set) var weatherHours: [ForecastWeatherItem] = []
    private(set) var cityName: String = ""
    weak var delegate: ForecastViewModelProtocol?
    
    func fetchData() {
        let url = API.forecast
        
        NetworkService.shared.getData(baseURL: url) { [weak self] (result: Result<ForecastResponse, Error>) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.weatherHours = response.list
                    self.delegate?.reloadData()
                    print(response.list.count)
                    
                case .failure(let error):
                    print("დაფიქსირდა შეცდომა: \(error.localizedDescription)")
                }
            }
        }
    }
}

