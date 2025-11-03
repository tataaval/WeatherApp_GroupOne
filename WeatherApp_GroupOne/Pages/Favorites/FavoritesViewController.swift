
//  FavoritesDetailsViewController.swift
//  WeatherApp_GroupOne
//
//  FavoritesViewController.swift
//

import UIKit

class FavoritesViewController: UIViewController {
    //MARK: Properties
    var cities: [String] = []
    var viewModel = FavoritesViewModel()
    //MARK: UI Components
    private let backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
        let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites list is empty"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupHeader()
        setupCollectionView()
        setupEmptyLabel()
        setupBindings()
        updateEmptyState()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    //MARK: Setup UI
    private func setupBackground() {
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupHeader() {
        view.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    private func setupEmptyLabel() {
        view.addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    private func updateEmptyState() {
           let isEmpty = cities.isEmpty
           collectionView.isHidden = isEmpty
           emptyLabel.isHidden = !isEmpty
       }
    
    private func setupBindings() {
          viewModel.onFavoritesUpdate = { [weak self] favorites in
              guard let self = self else { return }
              self.cities = favorites
              self.collectionView.reloadData()
              self.updateEmptyState()
          }
      }
    private func loadFavorites() {
            viewModel.loadFavorites()
        }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: "FavoritesCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isHidden = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor,constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

#Preview {
    FavoritesViewController()
}
