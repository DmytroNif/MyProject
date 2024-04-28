//
//  SearchTableViewCell.swift
//  MyProjectApp
//
//  Created by admin on 17/04/2024.
//

import Foundation
import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {
    
    var imagePoster: UIImageView = {
        let obj = UIImageView()
        return obj
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .black
        label.text = "Some text"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubview(label)
        addSubview(imagePoster)
        
        label.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().offset(2.sizeH)
            make.trailing.equalToSuperview().offset(2.sizeW)
            make.leading.equalToSuperview().offset(80.sizeW)
        }
        
        imagePoster.snp.makeConstraints { make in
            make.leading.bottom.top.equalToSuperview()
            make.trailing.equalTo(label.snp.leading).offset(-2)
        }
    }
    
    func setupCell(movie: Movie) {
        imagePoster.loadPoster(path: movie.posterPath ?? "")
        label.text = movie.title
    }
}
