//
//  NextItemButtons.swift
//  MyProjectApp
//
//  Created by admin on 01/02/2024.
//

import Foundation
import UIKit
import SnapKit

class NextItemButtonsVIew: UIView{
    
    let containerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .white
        return obj
    }()
    
    let previousButton: UIButton = {
        let obj = UIButton()
        obj.setTitle("<", for: .normal)
        return obj
    }()
    
    let nextButton: UIButton = {
        let obj = UIButton()
        obj.setTitle(">", for: .normal)
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
        containerView.addSubview(previousButton)
        containerView.addSubview(nextButton)
    }
    
    private func makeConstraints(){
        containerView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(40)
            make.trailing.equalToSuperview().offset(20)
            //не задана висота, треба якось це в'ю налаштувати
            //на рівні назви жанру
        }
        
        previousButton.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.leading.equalTo(containerView.snp.leading).offset(0)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.leading.equalTo(previousButton.snp.trailing).offset(0)
        }
    }
    
    private func LeftSetup() {
        addSubviews()
        makeConstraints()
    }
}


















