//
//  ViewController.swift
//  weather
//
//  Created by Natali Zhgenti on 01.11.25.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Static Properties
    private var viewModel: WeatherViewModel? = nil
    
    //MARK: - Private Properties
    private var weatherDetailsInCell: [WeatherDetailsInCell] = []
    private var weatherDetailsInHeader: WeatherDetailsInHeader = WeatherDetailsInHeader(icon: "", city: "", temperature: "", description: "")
    
    private let background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let detailsCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 157, height: 140)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 23
        flowLayout.sectionInset = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isUserInteractionEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        fetchData()
    }
    
    
    
    //MARK: - Methods
    
    private func setUpUI() {
        setUpBackground()
        setUpDetailsCollectionView()
    }
    
    private func setUpBackground() {
        view.addSubview(background)
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpDetailsCollectionView() {
        view.addSubview(detailsCollectionView)
        
        detailsCollectionView.delegate = self
        detailsCollectionView.dataSource = self
        detailsCollectionView.reloadData()
        detailsCollectionView.register(WeatherDetailsCell.self, forCellWithReuseIdentifier: WeatherDetailsCell.reuseIdentifier)
        detailsCollectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.reuseIdentifier)
        
        NSLayoutConstraint.activate([
            detailsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            detailsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            detailsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            detailsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    
    private func fetchData() {
        let url = API.currectWeather
        NetworkService.shared.getData(baseURL: url) {
            [weak self] (result: Result<WeatherData, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    
                    self.viewModel = WeatherViewModel(weatherData: response)
                    
                    if let viewModel = self.viewModel {
                        self.weatherDetailsInCell = [
                            WeatherDetailsInCell(icon: "thermometer.medium", title: "Feels like", description: "\(viewModel.feelsLike)°C"),
                            WeatherDetailsInCell(icon: "wind", title: "Wind", description: "\(viewModel.windSpeed) m/s, \(viewModel.windDirection)°"),
                            WeatherDetailsInCell(icon: "humidity", title: "Humidity", description: "\(viewModel.humidity)%"),
                            WeatherDetailsInCell(icon: "gauge.with.dots.needle.50percent", title: "Pressure", description: "\(viewModel.pressure) hPa"),
                            WeatherDetailsInCell(icon: "thermometer.low", title: "Today's Low", description: "\(viewModel.tempMin)°C"),
                            WeatherDetailsInCell(icon: "thermometer.high", title: "Today's High", description: "\(viewModel.tempMax)°C"),
                            WeatherDetailsInCell(icon: "sunrise", title: "Sunrise", description: "\(viewModel.sunrise)"),
                            WeatherDetailsInCell(icon: "sunset", title: "Sunset", description: "\(viewModel.sunset)"),
                        ]
                        
                        self.weatherDetailsInHeader = WeatherDetailsInHeader(
                            icon: "https://openweathermap.org/img/wn/\(viewModel.icon)@2x.png",
                            //                            city: viewModel.cityName,
                            city: "\(viewModel.cityName), \(viewModel.countryName)",
                            temperature: "\(viewModel.realTemperature)°C", description: viewModel.description
                        )
                    }
                    
                    self.detailsCollectionView.reloadData()
                    
                case .failure(let error):
                    print("დაფიქსირდა შეცდომა: \(error.localizedDescription)")
                }
            }
        }
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weatherDetailsInCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherDetailsCell.reuseIdentifier, for: indexPath) as? WeatherDetailsCell
        else { return UICollectionViewCell()}
        
        cell.configure(with: weatherDetailsInCell[indexPath.row])
        
        return cell
    }
}

//header
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CustomHeaderView.reuseIdentifier, for: indexPath) as? CustomHeaderView
        else { return UICollectionReusableView() }
        
        headerView.configure(with: weatherDetailsInHeader)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 300)
    }
}
