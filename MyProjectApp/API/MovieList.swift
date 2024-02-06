//
//  MovieList.swift
//  MyProjectApp
//
//  Created by admin on 29/01/2024.
//

import Foundation

struct MovieList: Codable {
    let genre: Genre
    let movies: [Movie]
    
    var previewMovies: [Movie] {
        return Array(movies.prefix(5))
    }
}

