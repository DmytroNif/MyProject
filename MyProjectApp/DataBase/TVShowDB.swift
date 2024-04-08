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
    @Persisted var originalLanguage: String = ""
    @Persisted var title: String = ""
    @Persisted var overview: String = ""
    @Persisted var posterPath: String = ""
    @Persisted var firstAirDate: String? = nil
    @Persisted var adult: Bool = true
    @Persisted var backdropPath: String = ""
    //  @Persisted var genreIDS: [Int] = []
    @Persisted var popularity: Double = 0.0
    @Persisted var voteAverage: Double = 0.0
    @Persisted var voteCount: Int = 0
    @Persisted var name: String = ""
  //  @Persisted var originCountry: [String] = []
    
    convenience init(tvShow: TVShow) {
        self.init()
        self.id = tvShow.id ?? 0
        self.originalLanguage = tvShow.originalLanguage ?? ""
        self.name = tvShow.name ?? ""
        self.overview = tvShow.overview ?? ""
        self.posterPath = tvShow.posterPath ?? ""
        self.backdropPath = tvShow.backdropPath ?? ""
     //   self.genreIDS = tvShow.genreIDS
        self.popularity = tvShow.popularity ?? 0
        self.voteAverage = tvShow.voteAverage ?? 0
        self.voteCount = tvShow.voteCount ?? 0
        self.firstAirDate = tvShow.firstAirDate
      //  self.originCountry = tvShow.originCountry
    }
}
