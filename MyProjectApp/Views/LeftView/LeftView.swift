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
        obj.backgroundColor = .white
        return obj
    }()
    
    let search: UISearchBar = {
        let obj = UISearchBar()
//        obj.barTintColor = .lightGray
        obj.isHidden = false
        obj.backgroundColor = .clear
        obj.layer.cornerRadius = 10
        return obj
    }()
    
    let showSearch: UIButton = {
        let obj = UIButton()
        obj.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        obj.isHidden = true
        return obj
    }()
    
    let segmentedControl: UISegmentedControl = {
            let control = UISegmentedControl(items: ["movies", "series"])
            control.selectedSegmentIndex = 0
            return control
        }()
    
    let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical // вертикальна прокрутка

            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            return collectionView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(showSearch)
        
        showSearch.addTarget(self, action: #selector(showSearchTapped), for: .touchUpInside)
        
        LeftSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showSearchTapped() {
        search.isHidden = false
        showSearch.isHidden = true
        search.becomeFirstResponder()
    }
    
    private func addSubviews(){
        self.addSubview(containerView)
        containerView.addSubview(search)
        search.addSubview(showSearch)
        containerView.addSubview(segmentedControl)
        containerView.addSubview(collectionView)
    }
    
    private func makeConstraints(){
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        search.snp.makeConstraints() { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        showSearch.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(150)
            make.top.equalTo(search.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func LeftSetup() {
        addSubviews()
        makeConstraints()
    }
}
