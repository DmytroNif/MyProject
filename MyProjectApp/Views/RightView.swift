//
//  RightView.swift
//  MyProjectApp
//
//  Created by admin on 26/01/2024.
//

import Foundation
import UIKit
import SnapKit

class RightView: UIView{
    
    let containerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .white
        return obj
    }()
    
    let tableView: UITableView = {
        
       return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        RightSetup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(){
        self.addSubview(containerView)
        containerView.addSubview(search)
        containerView.addSubview(tableView)
    }
    
    private func makeConstraints(){
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
    }
    private func RightSetup() {
        addSubviews()
        makeConstraints()
    }
}










