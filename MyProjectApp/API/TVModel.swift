//
//  TVModel.swift
//  MyProjectApp
//
//  Created by admin on 25/03/2024.
//

import Foundation



// MARK: - Result
struct TVShowsModel: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: Int?
  //  let originalLanguage, overview: String
    let posterPath: String
//    let mediaType: String
    let genreIds: [Int]
    let popularity: Double
//    let releaseDate: String
//    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    var posterURL: URL? {
           let baseURL = "https://image.tmdb.org/t/p/w500"
           return URL(string: baseURL + posterPath)
       }
        
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case title = "original_name"
       // case originalLanguage = "original_language"
//        case originalTitle = "original_title"
    //    case overview
        case posterPath = "poster_path"
//        case mediaType = "media_type"
        case genreIds = "genre_ids"
        case popularity
//        case releaseDate = "release_date"
//        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//enum MediaType: String, Codable {
//    case movie = "movie"
//}
