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
        obj.contentMode = .scaleAspectFill
        return obj
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
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
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubview(label)
        addSubview(imagePoster)
        
        label.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(3)
        }
        
        imagePoster.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(label.snp.top).offset(-2)
        }
    }
    
    func setupCell(model: Movie) {
        label.text = model.title
        imagePoster.sd_setImage(with: model.imageURL)
    }
    
    func setupTVCell(model: TVShow){
        
    }
}
