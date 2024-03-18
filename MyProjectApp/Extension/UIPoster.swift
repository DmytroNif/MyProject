//
//  UIPoster.swift
//  MyProjectApp
//
//  Created by admin on 16/03/2024.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func loadPoster(path: String) {
        let baseURL = Constant.posterBaseURL
        let posterURL = URL(string: baseURL + path)
        self.sd_setImage(with: posterURL)
    }
}
