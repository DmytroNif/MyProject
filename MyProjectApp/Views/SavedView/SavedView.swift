//
//  RightView.swift
//  MyProjectApp
//
//  Created by admin on 26/01/2024.
//

import Foundation
import UIKit
import SnapKit

class SavedView: UIView{
    
    private var movies: [Movie] = []
    
    let containerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .white
        return obj
    }()
    
    let headerLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.text = "Saved"
        obj.font = UIFont.preferredFont(forTextStyle: .headline).withSize(40.sizeH)
        return obj
    }()
    
    let tableView: UITableView = {
        let obj = UITableView()
       return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        savedSetup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(){
        self.addSubview(containerView)
        containerView.addSubview(tableView)
        containerView.addSubview(headerLabel)
    }
    
    private func makeConstraints(){
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaInsets.bottom).offset(50.sizeH)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(containerView)
            make.top.equalTo(headerLabel.snp.bottom)
        }
    }
    private func savedSetup() {
        addSubviews()
        makeConstraints()
    }
    
     func deleteMovie(indexPath: IndexPath) {
        movies.remove(at: indexPath.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}










