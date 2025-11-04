//
//  FavoritesDetailsViewController.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 02.11.25.
//
// 
import UIKit

final class FavoritesDetailsViewController: UIViewController {
    var onFavoritesChanged: (() -> Void)?
    
    // MARK: - Properties
    private let viewModel: FavoritesDetailsViewModel
    
    private var items: [(icon: String, title: String, value: String)] = []
    // MARK: - UI Components    
    private let weatherInfoView: WeatherInfoView = {
        let view = WeatherInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let notFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "City not found"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Init
    init(viewModel: FavoritesDetailsViewModel) {
       self.viewModel = viewModel
       super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setBackgroundImage()
        setupUI()
        setupCollectionView()
        setupBindings()
        
        loadingIndicator.startAnimating()
        viewModel.fetchWeather()
        viewModel.checkIfFavorite()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        setupWeatherInfoView()
        setupNotFoundLabel()
        setupLoadingIndicator()
    }

    // MARK: - UI Setup
    private func setupWeatherInfoView() {
        view.addSubview(weatherInfoView)
        NSLayoutConstraint.activate([
            weatherInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            weatherInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func setupNotFoundLabel() {
        view.addSubview(notFoundLabel)
        NSLayoutConstraint.activate([
            notFoundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notFoundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    
    private func setupCollectionView() {
        weatherInfoView.collectionView.dataSource = self
        weatherInfoView.collectionView.delegate = self
        weatherInfoView.collectionView.register(SearchForecastCell.self, forCellWithReuseIdentifier: SearchForecastCell.identifier)
    }
    
    private func setupBindings() {
        viewModel.onWeatherUpdate = { [weak self] weather in
            guard let self = self else { return }
            self.loadingIndicator.stopAnimating()
            self.updateUI(with: weather)
        }
        
        viewModel.onError = { [weak self] errorMessage in
            guard let self = self else { return }
            self.loadingIndicator.stopAnimating()
            self.weatherInfoView.isHidden = true
            self.notFoundLabel.isHidden = false
        }
        
        weatherInfoView.onBookmarkTapped = { [weak self] name in
            self?.viewModel.toggleFavorite()
            self?.onFavoritesChanged?()
        }

        viewModel.updateFavoriteButton = { [weak self] isFavorite in
           self?.weatherInfoView.updateBadge(isFavorite: isFavorite)
        }
    }
    
    // MARK: - Data Methods
    private func fetchWeatherData() {
        loadingIndicator.startAnimating()
        notFoundLabel.isHidden = true
        weatherInfoView.isHidden = true
        viewModel.fetchWeather()
    }
    
    // MARK: - UI Update
    private func updateUI(with weather: WeatherResponse) {
        self.notFoundLabel.isHidden = true
        guard let first = weather.weather.first else { return }
        let temp = "\(Int(weather.main.temp))°C"
        let humidity = "\(weather.main.humidity)%"
        let pressure = "\(weather.main.pressure) hPa"
        let iconURL = "https://openweathermap.org/img/wn/\(first.icon)@2x.png"
        
        self.items = [
            (iconURL, "Condition", first.description.capitalized),
            ("thermometer", "Temperature", temp),
            ("drop.fill", "Humidity", humidity),
            ("gauge", "Pressure", pressure)
        ]
        
        self.weatherInfoView.isHidden = false
        self.weatherInfoView.configure(cityName: viewModel.cityName.capitalized)
        self.weatherInfoView.collectionView.reloadData()
    }
}
//Mark: CollectionView Datasource + Delegate
extension FavoritesDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchForecastCell.identifier, for: indexPath) as? SearchForecastCell else {return UICollectionViewCell()}
        
        if item.icon.starts(with: "http") {
            cell.configure(icon: nil, title: item.title, value: item.value)
            cell.loadIcon(from: URL(string: item.icon))
        } else {
            cell.configure(icon: UIImage(systemName: item.icon), title: item.title, value: item.value)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 60)
    }
}
