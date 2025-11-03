
import UIKit

class ForecastViewController: UIViewController {
    
    let identifier = "ForecastCell"
    
    private let viewModel = ForecastViewModel()
    
    private let backgroundImage = UIImageView()
    
    private let forecastList: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupTableView()
        viewModel.fetchData()
        forecastList.register(ForecastCell.self, forCellReuseIdentifier: identifier)
        viewModel.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage.background
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func setupTableView() {
        view.addSubview(forecastList)
        
        forecastList.delegate = self
        forecastList.dataSource = self
        
        NSLayoutConstraint.activate([
            forecastList.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 16),
            forecastList.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -16),
            forecastList.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -10),
            forecastList.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 90)
        ])
    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.weatherHours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = forecastList.dequeueReusableCell(withIdentifier: identifier) as? ForecastCell else { return UITableViewCell() }
        let forecast = viewModel.weatherHours[indexPath.row]
        cell.configure(with: forecast)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel()
        label.text = "Forecast"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

}

extension ForecastViewController: ForecastViewModelProtocol {
    func reloadData() {
        forecastList.reloadData()
    }
    
}
