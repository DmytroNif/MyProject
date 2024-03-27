//
//  LeftViewController.swift
//  MyProjectApp
//
//  Created by admin on 26/01/2024.
//

import UIKit
import ProgressHUD

class LeftViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    let genresData = Genre.allCases
    
    let mainView = LeftView()
    var storage = StorageImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        mainView.segmentedControl.addTarget(self, action: #selector(segmentControlTaped), for: .valueChanged)
        mainView.collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
    }
    
    @objc
    private func segmentControlTaped() {
        if mainView.segmentedControl.selectedSegmentIndex == 0 {
            print(mainView.segmentedControl.selectedSegmentIndex)
        } else {
            print(mainView.segmentedControl.selectedSegmentIndex)
        }
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
}

extension LeftViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        cell.backgroundColor = .black
        cell.clipsToBounds = true
        cell.type = .movie
        cell.genre = genresData[indexPath.section]
        
        cell.didSelectItem = { [weak self] movie in
            let movieDetailsViewController = DetailsViewController()
            movieDetailsViewController.movie = movie
            
            NetworkManager().getDetails(id: movie.id) { result in
                
                switch result {
                    
                case .success(let movie):
                    movieDetailsViewController.mainView.setupUI(model: movie)
                    self?.navigationController?.pushViewController(movieDetailsViewController, animated: true)
                case .failure(_):
                    print("Can't get data")
                }
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


