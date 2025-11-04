
import UIKit

class ForecastViewController: UIViewController {
    
    let identifier = "ForecastCell"
    
    private let viewModel: ForecastViewModel
    
    private let forecastList: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let headerView: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .cell.withAlphaComponent(0.3)
        headerView.clipsToBounds = true
        headerView.layer.cornerRadius = 12
        return headerView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Forecast"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setBackgroundImage()
        setupHeaderView()
        setupTableView()
        viewModel.fetchData()
        forecastList.register(ForecastCell.self, forCellReuseIdentifier: identifier)
        viewModel.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerView.heightAnchor.constraint(equalToConstant: 50),
           
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
       
    }
    
    private func setupTableView() {
        view.addSubview(forecastList)
        
        forecastList.delegate = self
        forecastList.dataSource = self
        
        NSLayoutConstraint.activate([
            forecastList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            forecastList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            forecastList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            forecastList.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 5)
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
}

extension ForecastViewController: ForecastViewModelProtocol {
    func reloadData() {
        forecastList.reloadData()
    }
    
}
