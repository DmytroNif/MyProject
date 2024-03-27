//
//  MovieDetails.swift
//  MyProjectApp
//
//  Created by admin on 29/01/2024.
//

import Foundation

struct MovieGenre: Codable {
    let id: Int
    let name: String
}

struct MovieVideos: Codable {
    let movies: [Video]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Video: Codable {
    let id: String
    let name: String
    let key: String
    let site: String
    let type: String
}

struct MovieDetails: Codable {
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let backdropPath: String
    let budget: Int
    let homepage: String
    let popularity: Double
    let status: String
    let videos: MovieVideos
    let genres: [MovieGenre]
    
    var imageURL: URL? {
        let baseURL = "https://image.tmdb.org/t/p/w500"
        return URL(string: baseURL + posterPath)
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
