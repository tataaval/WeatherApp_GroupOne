//
//  CustomHeaderView.swift
//  WeatherApp_GroupOne
//
//  Created by Natali Zhgenti on 02.11.25.
//

import UIKit

class CustomHeaderView: UICollectionReusableView {
    
    //MARK: - Static Properties
    static let reuseIdentifier = "CustomHeaderView"
    
    //MARK: - Private Properties
    private let headerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cityLabel = CustomLabel(UIFont.systemFont(ofSize: 28, weight: .semibold), .white)
    private let temperatureLabel = CustomLabel(UIFont.systemFont(ofSize: 34, weight: .semibold), .white)
    private let weatherDescriptionLabel = CustomLabel(UIFont.systemFont(ofSize: 22, weight: .regular), .lightGray)
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    private func setUpUI() {
        setUpMainInfoStack()
    }
    
    private func setUpMainInfoStack() {
        addSubview(headerStack)
        headerStack.addArrangedSubview(weatherIcon)
        headerStack.addArrangedSubview(cityLabel)
        headerStack.setCustomSpacing(15, after: cityLabel)
        headerStack.addArrangedSubview(temperatureLabel)
        headerStack.setCustomSpacing(6, after: temperatureLabel)
        headerStack.addArrangedSubview(weatherDescriptionLabel)
        
        NSLayoutConstraint.activate([
            headerStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerStack.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    
    func configure(with details: WeatherDetailsInHeader) {
        if let url = URL(string: details.icon) {
            weatherIcon.load(url: url)
        }
        cityLabel.text = details.city
        temperatureLabel.text = "\(details.temperature)"
        weatherDescriptionLabel.text = details.description
    }
}
