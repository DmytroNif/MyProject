//
//  TVShowDetails.swift
//  MyProjectApp
//
//  Created by admin on 23/03/2024.
//
//
import Foundation

struct TVShowGenre: Codable {
    let id: Int
    let name: String
}

struct TVShowVideos: Codable {
    let tvShows: [TVVideo]?
    
    enum CodingKeys: String, CodingKey {
        case tvShows = "TVresults"
    }
}

struct TVVideo: Codable {
    let id: String
    let name: String
    let key: String
    let site: String
    let type: String
}

struct TVShowDetails: Codable {
    let title: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let backdropPath: String?
    let budget: Int?
    let homepage: String?
    let popularity: Double?
    let status: String?
    let videos: TVShowVideos?
    let genres: [TVShowGenre]?
    
    var imageURL: URL? {
        let baseURL = "https://image.tmdb.org/t/p/w500"
        return URL(string: baseURL + (posterPath ?? ""))
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case budget = "budget"
        case homepage = "homepage"
        case popularity = "popularity"
        case status = "status"
        case videos = "videos"
        case genres = "genres"
    }
}
