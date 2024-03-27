//
//  TVShowList.swift
//  MyProjectApp
//
//  Created by admin on 23/03/2024.
//

import Foundation

struct TVShowList: Codable {
    let genre: Genre
    let tvShows: [TVShow]
    
    var previewMovies: [TVShow] {
        return Array(tvShows.prefix(5))
    }
}
