//
//  CollectionView.swift
//  MyProjectApp
//
//  Created by admin on 29/01/2024.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    let network = NetworkManager()
    
    var didSelectItem: ((Movie) -> Void)?
    
    var genre: Genre? {
        didSet {
            guard let genre = genre else { return }
            fetchMoviesForGenre(genre: genre)
        }
    }
    
    weak var coordinator: MainCoordinator?
    
    var movies: [Movie] = []
    
    let containerView: UIView = {
        let obj = UIView()
        return obj
    }()
    
    let horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(horizontalCollectionView)
    }
    
    private func fetchMoviesForGenre(genre: Genre) {
        network.discoverMovies(genres: [genre], page: 1) { [weak self] result in
            switch result {
            case .success(let data):
                self?.movies = data.first?.movies ?? []
                self?.horizontalCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupCollection() {
        horizontalCollectionView.register(HorizontalCell.self, forCellWithReuseIdentifier: "HorizontalCell")
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        horizontalCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }
}

// MARK: - Setup cell
extension MovieCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath) as! HorizontalCell
        cell.backgroundColor = .green
        
//        if let model = model[indexPath.row] {
        cell.setupCell(model: movies[indexPath.row])
        
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3
        let height: CGFloat = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        didSelectItem?(movie)
    }

}
