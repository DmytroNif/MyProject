//
//  MovieDB.swift
//  MyProjectApp
//
//  Created by admin on 29/01/2024.
//


import Foundation
import RealmSwift

class MovieDB: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var language: String = ""
    @Persisted var title: String = ""
    @Persisted var overview: String = ""
    @Persisted var posterPath: String = ""
    @Persisted var releaseDate: String? = nil
    @Persisted var adult: Bool = true
    @Persisted var backdropPath: String = ""
    @Persisted var genreIds: List<Int> = List<Int>()
    @Persisted var popularity: Double = 0.0
    @Persisted var voteAverage: Double = 0.0
    @Persisted var voteCount: Double = 0.0
    
    convenience init(movie: Movie) {
        self.init()
        self.id = movie.id ?? 0
        self.language = movie.language ?? ""
        self.title = movie.title ?? ""
        self.overview = movie.overview ?? ""
        self.posterPath = movie.posterPath ?? ""
        self.releaseDate = movie.releaseDate
        self.adult = movie.adult ?? false
        self.backdropPath = movie.backdropPath ?? ""
        self.genreIds.append(objectsIn: movie.genreIds ?? [0])
        self.popularity = movie.popularity ?? 0
        self.voteAverage = movie.voteAverage ?? 0
        self.voteCount = movie.voteCount ?? 0
    }
}

