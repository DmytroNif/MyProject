//
//  TVShow.swift
//  MyProjectApp
//
//  Created by admin on 23/03/2024.
//

import Foundation


struct TVShow: Codable {
    let id: Int
    let language: String
    let title: String?
   // let originalLanguage: String
    let overview: String
    let posterPath: String
    let releaseDate: String?
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let popularity: Double
    let voteAverage: Double
    let voteCount: Double
    
    var imageURL: URL? {
        let baseURL = "https://image.tmdb.org/t/p/w500"
        return URL(string: baseURL + posterPath)
    }
    
    var geners: [MovieGenre] {
        let geners = Genre.allCases.filter({ genreIds.contains($0.rawValue) })
        return geners.prefix(3).compactMap { .init(id: $0.rawValue, name: "") }
    }
    
    init(tvShowDB: TVShowDB) {
        self.id = tvShowDB.id
        self.language = tvShowDB.language
        self.title = tvShowDB.title
        self.overview = tvShowDB.overview
        self.posterPath = tvShowDB.posterPath
        self.releaseDate = tvShowDB.releaseDate
        self.adult = tvShowDB.adult
        self.backdropPath = tvShowDB.backdropPath
        self.genreIds = tvShowDB.genreIds.compactMap { $0 }
        self.popularity = tvShowDB.popularity
        self.voteAverage = tvShowDB.voteAverage
        self.voteCount = tvShowDB.voteCount
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case language = "original_language"
        case title = "original_name"
       // case originalLanguage = "original_language"
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
