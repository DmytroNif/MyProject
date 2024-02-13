//
//  Movie.swift
//  MyProjectApp
//
//  Created by admin on 29/01/2024.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let language: String
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String?
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let popularity: Double
    let voteAverage: Double
    let voteCount: Double
    
    var geners: [MovieGenre] {
        let geners = Genre.allCases.filter({ genreIds.contains($0.rawValue) })
        return geners.prefix(3).compactMap { .init(id: $0.rawValue, name: "") }
    }
    
    init(movieDB: MovieDB) {
        self.id = movieDB.id
        self.language = movieDB.language
        self.title = movieDB.title
        self.overview = movieDB.overview
        self.posterPath = movieDB.posterPath
        self.releaseDate = movieDB.releaseDate
        self.adult = movieDB.adult
        self.backdropPath = movieDB.backdropPath
        self.genreIds = movieDB.genreIds.compactMap { $0 }
        self.popularity = movieDB.popularity
        self.voteAverage = movieDB.voteAverage
        self.voteCount = movieDB.voteCount
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case language = "original_language"
        case title = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case popularity = "popularity"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

