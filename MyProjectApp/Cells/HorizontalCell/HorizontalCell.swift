//
//  HorizontalCell.swift
//  MyProjectApp
//
//  Created by admin on 29/02/2024.
//

import UIKit

class HorizontalCell: UICollectionViewCell {
    
    var imagePoster: UIImageView = {
       let obj = UIImageView()
        
        return obj
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black.withAlphaComponent(0.8)
        label.text = "Some text"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .orange
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubview(imagePoster)
        addSubview(label)
        
        imagePoster.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(105)
        }
    }
    
    func setupCell(model: Movie) {
        label.text = model.title
        imagePoster.sd_setImage(with: model.imageURL)
    }
}
