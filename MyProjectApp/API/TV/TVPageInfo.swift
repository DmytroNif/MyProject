//
//  TVPageInfo.swift
//  MyProjectApp
//
//  Created by admin on 26/03/2024.
//

import Foundation

struct TVShowsPageInfo: Codable {
    let page: Int
    let results: [TVShow]?
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
