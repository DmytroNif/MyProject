//
//  LeftView.swift
//  MyProjectApp
//
//  Created by admin on 27/01/2024.
//

import Foundation
import UIKit
import SnapKit

class LeftView: UIView{
    
    let containerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .black
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
        LeftSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews(){
        self.addSubview(containerView)
        containerView.addSubview(collectionView)
    }
    
    private func makeConstraints(){
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func LeftSetup() {
        addSubviews()
        makeConstraints()
    }
}
