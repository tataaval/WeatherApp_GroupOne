//
//  WeatherDetailsCell.swift
//  weather
//
//  Created by Natali Zhgenti on 01.11.25.
//

import UIKit

class WeatherDetailsCell: UICollectionViewCell {
    
    //MARK: - Static Properties
    static let reuseIdentifier = "WeatherDetailsCell"
    
    //MARK: - Private Properties
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let weatherInfoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel = CustomLabel(UIFont.systemFont(ofSize: 20, weight: .semibold), .white)
    private let valueLabel = CustomLabel(UIFont.systemFont(ofSize: 16, weight: .regular), .white)
    
    
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
        backgroundColor = UIColor(named: "CustomPurple")//?.withAlphaComponent(0.7)
        layer.cornerRadius = 25
        
        setUpCellStackView()
    }
    
    private func setUpCellStackView() {
        contentView.addSubview(weatherInfoStack)
        weatherInfoStack.addArrangedSubview(iconImageView)
        weatherInfoStack.addArrangedSubview(titleLabel)
        weatherInfoStack.addArrangedSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            weatherInfoStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherInfoStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configure(with details: WeatherDetailsInCell) {
        iconImageView.image = UIImage(systemName: details.icon)
        titleLabel.text = details.title
        valueLabel.text = details.description
    }
}
