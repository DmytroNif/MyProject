//
//  LeftViewController.swift
//  MyProjectApp
//
//  Created by admin on 26/01/2024.
//

import UIKit

class LeftViewController: UIViewController {
    

    let mainView = LeftView()
//    var genresTiteles = Genre.allCases
    
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

extension LeftViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Поверніть кількість фільмів, які ви хочете відображати
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        // Налаштуйте вашу ячейку з фільмом тут
        cell.clipsToBounds = true
        cell.backgroundColor = .white
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Genre.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
           // let genre = Genre.
        //    headerView.titleLabel.text =
                   return headerView
        } else {
            fatalError("Unexpected supplementary element kind")
        }
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3 - 10 // Розрахунок ширини кожної ячейки з відступом
        let height: CGFloat = collectionView.bounds.height / 3 // Висота кожної секції - 1/3 від висоти UICollectionView
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 9) // Висота заголовка - 1/9 від висоти UICollectionView
    }
}


