//
//  ItemModel.swift
//  MyProjectApp
//
//  Created by admin on 31/01/2024.
//

import Foundation
import UIKit
import SnapKit

class ItemModelView: UIView{
    
    let containerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .white
        return obj
    }()
    
    let imageView: UIImageView = {
      let obj = UIImageView()
        
        return obj
    }()
    
    let nameOfMovieLabel: UILabel = {
      let obj = UILabel()
        
        return obj
    }()
    
    let movieInfoLabel: UILabel = {
      let obj = UILabel()
        
        return obj
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
        containerView.addSubview(imageView)
        containerView.addSubview(nameOfMovieLabel)
        containerView.addSubview(movieInfoLabel)
    }
    
    private func makeConstraints(){
        containerView.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.width.equalTo(100)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(220)
            //десь тут може бути помилка
            make.top.leading.equalTo(containerView).offset(0)
        }
        
        nameOfMovieLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(0)
        }
        
        movieInfoLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(nameOfMovieLabel.snp.bottom).offset(0)
        }
    }
    
    private func LeftSetup() {
        addSubviews()
        makeConstraints()
    }
    
}














