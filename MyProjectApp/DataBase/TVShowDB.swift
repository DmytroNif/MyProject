//
//  TVShowDB.swift
//  MyProjectApp
//
//  Created by admin on 26/03/2024.
//

import Foundation
import RealmSwift

class TVShowDB: Object {
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
    
    convenience init(tvShow: TVShow) {
        self.init()
        self.id = tvShow.id
        self.language = tvShow.language
        self.title = tvShow.title ?? ""
        self.overview = tvShow.overview
        self.posterPath = tvShow.posterPath
        self.releaseDate = tvShow.releaseDate
        self.adult = tvShow.adult
        self.backdropPath = tvShow.backdropPath
        self.genreIds.append(objectsIn: tvShow.genreIds)
        self.popularity = tvShow.popularity
        self.voteAverage = tvShow.voteAverage
        self.voteCount = tvShow.voteCount
    }
}
