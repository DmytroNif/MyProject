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
    
    let searchTextField: UITextField = {
            let textField = UITextField()
            textField.backgroundColor = UIColor.lightGray
            textField.layer.cornerRadius = 5
            textField.clipsToBounds = true
        
        // Setting up leftView with an image
                let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
                imageView.contentMode = .scaleAspectFit
                let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20)) // Adjust the frame as per your needs
                imageView.frame = paddingView.bounds
                paddingView.addSubview(imageView)
                textField.leftView = paddingView
                textField.leftViewMode = .always
                
                textField.placeholder = "Search..."
                
                return textField
        }()
    
//    let search: UISearchBar = {
//        let obj = UISearchBar()
//        obj.backgroundColor = .systemBlue
//        obj.barTintColor = .lightGray.withAlphaComponent(0.5)
//        obj.isHidden = true
//        obj.layer.cornerRadius = 10
//        return obj
//    }()
//    
//    let showSearch: UIButton = {
//        let obj = UIButton()
//        obj.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
//        obj.isHidden = false
//        return obj
//    }()
    
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
        
        
        
//        showSearch.addTarget(self, action: #selector(showSearchTapped), for: .touchUpInside)
        
        LeftSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc func showSearchTapped() {
//        search.isHidden = false
//        showSearch.isHidden = true
//        search.becomeFirstResponder()
//    }
    
    private func addSubviews(){
        self.addSubview(containerView)
//        containerView.addSubview(search)
//        containerView.addSubview(showSearch)
        containerView.addSubview(searchTextField)
        containerView.addSubview(segmentedControl)
        containerView.addSubview(collectionView)
    }
    
    private func makeConstraints(){
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        search.snp.makeConstraints() { make in
//            make.height.equalTo(30)
//            make.width.equalTo(300)
//            make.centerX.equalToSuperview().offset(0)
//            make.centerY.equalToSuperview().offset(-350)
//            make.leading.trailing.equalToSuperview()
//        }
//        
//        showSearch.snp.makeConstraints { make in
//            make.height.equalTo(30)
//            make.width.equalTo(20)
//            make.centerX.equalToSuperview().offset(-170)
//            make.centerY.equalToSuperview().offset(-350)
//        }
        
        searchTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(300)
            make.centerX.equalToSuperview().offset(0)
            make.centerY.equalToSuperview().offset(-350)
            make.leading.trailing.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(150)
            make.centerX.equalToSuperview().offset(0)
            make.centerY.equalToSuperview().offset(-320)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(0)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func LeftSetup() {
        addSubviews()
        makeConstraints()
    }
}
