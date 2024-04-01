//
//  TVShowVIewController.swift
//  MyProjectApp
//
//  Created by admin on 23/03/2024.
//


import UIKit
import ProgressHUD

class TVShowViewController: UIViewController {
    
    let genresData = Genre.allCases
    let mainView = TVShowView()
    let manager = NetworkManager()
    var storage = StorageImpl()
    weak var coordinator: MainCoordinator?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            mainView.collectionView.dataSource = self
            mainView.collectionView.delegate = self
            mainView.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
            mainView.collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        }
        
        override func loadView() {
            super.loadView()
            view = mainView
        }
    }

    extension TVShowViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
            cell.backgroundColor = .black
            cell.clipsToBounds = true
            cell.type = .tv
            cell.genre = genresData[indexPath.section]
            
            cell.didSelectTvItem = { [weak self] tvShow in
                let tvShowDetailsViewController = DetailsViewController()
                tvShowDetailsViewController.tvShow = tvShow
                
                NetworkManager().getTVDetails(id: tvShow.id ?? 0) { result in
                    
                    switch result {
                        
                    case .success(let tvShow):
                        tvShowDetailsViewController.mainView.setupTVUI(model: tvShow)
                        tvShowDetailsViewController.type = .tv
                        self?.navigationController?.pushViewController(tvShowDetailsViewController, animated: true)
                    case .failure(_):
                        let alertController = UIAlertController(title: "Sorry", message: "No details available for this one", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
                        collectionView.window?.rootViewController?.present(alertController, animated: true, completion: nil)                    }
                }
                
            }
            
            return cell
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return Genre.allCases.count
        }
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
                headerView.backgroundColor = .black
                headerView.titleLabel.text = genresData[indexPath.section].title
                return headerView
            } else {
                fatalError("Unexpected supplementary element kind")
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width
            let height: CGFloat = collectionView.bounds.height / 3
            return CGSize(width: width, height: height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 9)
        }
    }
    
    
    

