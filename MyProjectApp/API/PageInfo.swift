//
//  PageInfo.swift
//  MyProjectApp
//
//  Created by admin on 29/01/2024.
//

import Foundation

struct PageInfo: Codable {
    let page: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case movies = "results"
    }
}

