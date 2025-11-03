//
//  SearchViewController.swift
//  WeatherApp_GroupOne
//
//  Created by Tatarella on 02.11.25.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - UI
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let weatherInfoView: WeatherInfoView = {
        let view = WeatherInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter city name"
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setLeftPaddingPoints(12)
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    // MARK: - ViewModel
    private let viewModel = SearchViewModel()
    
    // MARK: - Data
    private var items: [(icon: String, title: String, value: String)] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupBindings()
        setupCollectionView()
        
        searchField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchField.text = ""
        weatherInfoView.isHidden = true
        notFoundLabel.isHidden = true
        weatherInfoView.collectionView.reloadData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(searchField)
        view.addSubview(searchButton)
        view.addSubview(weatherInfoView)
        view.addSubview(notFoundLabel)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -8),
            searchField.heightAnchor.constraint(equalToConstant: 44),
            
            searchButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.widthAnchor.constraint(equalToConstant: 44),
            searchButton.heightAnchor.constraint(equalToConstant: 44),
            
            weatherInfoView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 100),
            weatherInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            notFoundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notFoundLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        weatherInfoView.collectionView.dataSource = self
        weatherInfoView.collectionView.delegate = self
        weatherInfoView.collectionView.register(SearchForecastCell.self, forCellWithReuseIdentifier: SearchForecastCell.identifier)
    }
    
    private func setupBindings() {
        // ViewModel იღებს დატას
        viewModel.onWeatherUpdate = { [weak self] weather in
            guard let self = self else { return }
            self.updateUI(with: weather)
        }
        
        // ViewModel ფეილდებდა 
        viewModel.onError = { [weak self] errorMessage in
            guard let self = self else { return }
            
            self.weatherInfoView.isHidden = true
            self.items.removeAll()
            self.weatherInfoView.collectionView.reloadData()
            
            self.notFoundLabel.isHidden = false
            
            
        }
    }
    
    // MARK: - Actions
    @objc private func searchTapped() {
        guard let city = searchField.text, !city.isEmpty else { return }
        viewModel.fetchWeather(for: city)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            weatherInfoView.isHidden = true
            items.removeAll()
            weatherInfoView.collectionView.reloadData()
        }
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
        self.weatherInfoView.configure(cityName: searchField.text?.capitalized ?? "")
        self.weatherInfoView.collectionView.reloadData()
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchForecastCell.identifier, for: indexPath) as! SearchForecastCell
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

