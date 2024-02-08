//
//  DetailsView.swift
//  MyProjectApp
//
//  Created by admin on 07/02/2024.
//

import Foundation
import SnapKit
import UIKit
import YouTubeiOSPlayerHelper

class DetailsView: UIView{
    
    let containerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .white
        return obj
    }()
    
    let youtubePlayer: YTPlayerView = {
        let obj = YTPlayerView()
        
        return obj
    }()
    
    let titleLabel: UILabel = {
        let obj = UILabel()
        
        return obj
    }()
    
    let dateLabel: UILabel = {
        let obj = UILabel()
        
        return obj
    }()
    
    let descriptionLabel: UILabel = {
        let obj = UILabel()
        
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        DetailsSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(){
        self.addSubview(containerView)
        containerView.addSubview(youtubePlayer)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(descriptionLabel)
    }
    
    private func makeConstraints(){
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        youtubePlayer.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(300)
            make.centerX.equalToSuperview().offset(0)
            make.centerY.equalToSuperview().offset(-350)
            make.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(youtubePlayer.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func DetailsSetup() {
        addSubviews()
        makeConstraints()
    }
}