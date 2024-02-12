//
//  HeaderVIew.swift
//  MyProjectApp
//
//  Created by admin on 29/01/2024.
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {
    
    var genresTiteles = Genre.allCases
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = genresTiteles
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        // Налаштуйте constraints для titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
