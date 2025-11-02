
import UIKit

class ForecastCell: UITableViewCell {

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cell
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private let weatherLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.testLogo
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2025-11-02 12:00:00"
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .bold)
        return label
    }()
    private let time = Double()
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "30 C"
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        setupContainerView()
        setupWeatherLogo()
        setupWeatherLabel()
        setupTimeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,  constant: -5).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7).isActive = true
    }
    
    private func setupWeatherLogo() {
        containerView.addSubview(weatherLogo)
        
        weatherLogo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        weatherLogo.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
    private func setupWeatherLabel() {
        containerView.addSubview(tempLabel)
        
        tempLabel.leadingAnchor.constraint(equalTo: weatherLogo.trailingAnchor, constant: 5).isActive = true
        tempLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        tempLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
    }
    
    private func setupTimeLabel() {
        containerView.addSubview(timeLabel)
        
        timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
    }
    
    func configure(with weather: WeatherItem) {
        timeLabel.text = weather.dt_txt
        tempLabel.text = "\(weather.main.temp)"
//        weatherLogo.image = weather.weather.icon
        
    }
}
