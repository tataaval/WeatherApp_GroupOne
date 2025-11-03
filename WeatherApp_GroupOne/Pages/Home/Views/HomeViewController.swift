//
//  ViewController.swift
//  weather
//
//  Created by Natali Zhgenti on 01.11.25.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Private Properties
    private var viewModel: WeatherViewModel
    private weak var coordinator: TabBarCoordinator?
    
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
    
    //MARK: - Init
    init(viewModel: WeatherViewModel, coordinator: TabBarCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        bindViewModel()
        viewModel.fetchData()
    }
    
    //MARK: - Methods
    private func bindViewModel() {
        viewModel.onWeatherDataFetched = { [weak self] weather in
            guard let self = self else { return }
            self.weatherDetailsInHeader = self.viewModel.weatherDetailsInHeader
            self.weatherDetailsInCell = self.viewModel.weatherDetailsInCell
            self.detailsCollectionView.reloadData()
        }
        
        viewModel.onError = { [weak self] error in
            guard let self = self else { return }
            self.presentAlert(message: error)
        }
    }
    
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: "დაფიქსირდა შეცდომა", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
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
            detailsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
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
