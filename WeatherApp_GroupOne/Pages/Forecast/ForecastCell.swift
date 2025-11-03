
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
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .bold)
        return label
    }()
    private let time = Double()
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,  constant: -5),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7)
        ])
        
    }
    
    private func setupWeatherLogo() {
        containerView.addSubview(weatherLogo)
        
        NSLayoutConstraint.activate([
            weatherLogo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            weatherLogo.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            weatherLogo.heightAnchor.constraint(equalToConstant: 60),
            weatherLogo.widthAnchor.constraint(equalToConstant: 60)
        ])
       
    }
    
    private func setupWeatherLabel() {
        containerView.addSubview(tempLabel)
        
        NSLayoutConstraint.activate([
            tempLabel.leadingAnchor.constraint(equalTo: weatherLogo.trailingAnchor, constant: 5),
            tempLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            tempLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
          ])
        }
    
    private func setupTimeLabel() {
        containerView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        ])
        
    }
    
    func configure(with weather: ForecastWeatherItem) {
        timeLabel.text = weather.dt_txt
        tempLabel.text = "\(weather.main.temp)"
//        weatherLogo.image = weather.weather.icon
        
    }
}
