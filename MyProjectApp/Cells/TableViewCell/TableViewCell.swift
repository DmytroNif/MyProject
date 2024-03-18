//
//  TableViewCell.swift
//  MyProjectApp
//
//  Created by admin on 16/03/2024.
//

import Foundation
import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    
    var imagePoster: UIImageView = {
       let obj = UIImageView()
        obj.contentMode = .scaleAspectFill
        return obj
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .black
        label.text = "Some text"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private func setupViews() {
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubview(label)
        addSubview(imagePoster)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imagePoster.snp.makeConstraints { make in
            make.leading.bottom.top.equalToSuperview()
            make.trailing.equalTo(label.snp.leading).offset(-2)
        }
    }
    func setupCell(movie: Movie) {
        imagePoster.loadPoster(path: movie.posterPath)
        label.text = movie.title
    }
}
