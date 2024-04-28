//
//  LeftView.swift
//  MyProjectApp
//
//  Created by admin on 27/01/2024.
//

import Foundation
import UIKit
import SnapKit

class MovieView: UIView{
    
    let containerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .black
        return obj
    }()
    
    let headerLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .white
        obj.text = "Movies"
        obj.font = UIFont.preferredFont(forTextStyle: .headline).withSize(40.sizeH)
        return obj
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // вертикальна прокрутка
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        movieSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews(){
        self.addSubview(containerView)
        containerView.addSubview(collectionView)
        containerView.addSubview(headerLabel)
    }
    
    private func makeConstraints(){
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaInsets.bottom).offset(50.sizeH)
        }
    }
    
    private func movieSetup() {
        addSubviews()
        makeConstraints()
    }
}
