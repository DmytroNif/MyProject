//
//  SearchView.swift
//  MyProjectApp
//
//  Created by admin on 24/03/2024.
//

import Foundation
import UIKit
import SnapKit

class SearchView: UIView{
    
    let containerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .black
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
    
    let searchTableView: UITableView = {
        let tableView = UITableView()
        
        
        return tableView
    }()
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          
        SearchSetup()

      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    private func addSubviews(){
        self.addSubview(containerView)
        
        containerView.addSubview(searchTextField)
        containerView.addSubview(searchTableView)
        
    }
    
    private func makeConstraints(){
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(300)
            make.centerX.equalToSuperview().offset(0)
            make.centerY.equalToSuperview().offset(-200)
            make.leading.trailing.equalToSuperview()
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
        
    private func SearchSetup() {
           addSubviews()
           makeConstraints()
       }
}
