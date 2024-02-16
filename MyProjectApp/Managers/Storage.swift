//
//  Storage.swift
//  MyProjectApp
//
//  Created by admin on 29/01/2024.
//

import Foundation
import RealmSwift

enum StorageError: Error {
    case noObject
    
    var errorDescription: String? {
        switch self {
        case .noObject:
            return NSLocalizedString("No object found in the storage.", comment: "Storage error")
        }
    }
}

protocol Storage {
    func save(movie: Movie, completion: (() -> Void))
    func delete(movieId: Int, completion: ((Result<Int, Error>) -> Void))
    func fetchFavoriteMovies(completion: (([Movie]) -> ()))
}

class StorageImpl: Storage {
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
    
    func save(movie: Movie, completion: (() -> Void)) {
        try? realm.write {
            let movieDB = MovieDB(movie: movie)
            realm.add(movieDB, update: .all)
            completion()
        }
    }
    
    func delete(movieId: Int, completion: ((Result<Int, Error>) -> Void)) {
        if let movieDB = realm.object(ofType: MovieDB.self, forPrimaryKey: movieId) {
            try? realm.write {
                realm.delete(movieDB)
                completion(.success(movieId))
            }
        } else {
            completion(.failure(StorageError.noObject))
        }
    }
    
    func fetchFavoriteMovies(completion: (([Movie]) -> ())) {
        let favoriteMoviesDB = realm.objects(MovieDB.self)
        let favoriteMovies = Array(favoriteMoviesDB.map { Movie(movieDB: $0) })
        return completion(favoriteMovies)
    }
}

