//
//  Datasource+Delegate.swift
//  WeatherApp_GroupOne
//
//  Created by m1 pro on 02.11.25.
//

import UIKit
//Mark: CollectionView Datasource + Delegate
extension FavoritesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if cities.count == 0 {
            collectionView.isHidden = true
            emptyLabel.isHidden = false
            return 0
        } else {
            collectionView.isHidden = false
            emptyLabel.isHidden = true
            return cities.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath) as? FavoritesCell else {return UICollectionViewCell()}
          
        cell.locationLabel.text = cities[indexPath.section]
        return cell
            }
        }
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 40
        return CGSize(width: width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCity = cities[indexPath.section]
        let favoritesDetailsVC = FavoritesDetailsViewController()
        favoritesDetailsVC.cityName = selectedCity
        self.present(favoritesDetailsVC, animated: true)
    }
    
}
