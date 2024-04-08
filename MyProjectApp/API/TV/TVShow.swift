//
//  TVShow.swift
//  MyProjectApp
//
//  Created by admin on 23/03/2024.
//
import Foundation


struct TVShow: Codable {
    let backdropPath: String?
    let firstAirDate: String?
   // let genreIDS: [Int]
    let id: Int?
    let name: String?
  //  let originCountry: [String] = []
    let originalLanguage, overview: String?
    let popularity: Double?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    var imageURL: URL? {
        let baseURL = "https://image.tmdb.org/t/p/w500"
        return URL(string: baseURL + (posterPath ?? "" ))
    }
    
//    var geners: [TVShowGenre] {
//        let geners = Genre.allCases.filter({ (genreIDS ?? []).contains($0.rawValue) })
//        return geners.prefix(3).compactMap { .init(id: $0.rawValue, name: "") }
//    }
    
    init(tvShow: TVShowDB) {
        self.id = tvShow.id
        self.originalLanguage = tvShow.originalLanguage
        self.name = tvShow.title
        self.overview = tvShow.overview
        self.posterPath = tvShow.posterPath
        self.backdropPath = tvShow.backdropPath
      //  self.genreIDS = tvShow.genreIDS.compactMap { $0 }
        self.popularity = tvShow.popularity
        self.voteAverage = tvShow.voteAverage
        self.voteCount = tvShow.voteCount
        self.firstAirDate = tvShow.firstAirDate ?? ""
       // self.originCountry = tvShow.originCountry
    }

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
       // case genreIDS = "genre_ids"
        case id
        case name
       // case originCountry = "origin_country"
        case originalLanguage = "original_language"
      //  case originalName = "original_name"
        case overview
        case popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
