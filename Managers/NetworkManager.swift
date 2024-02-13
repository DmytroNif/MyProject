//
//  NetworkManager.swift
//  MyProjectApp
//
//  Created by admin on 29/01/2024.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private func fetchData<T: Decodable>(endpoint: Endpoint, completion: @escaping ((Result<T, Error>) -> Void)) {
        AF.request(endpoint)
            .validate()
            .responseDecodable(of: T.self) { response in
                print(response.debugDescription)
                switch response.result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
    }
    
    func getDetails(id: Int, completion: @escaping ((Result<MovieDetails, Error>) -> Void)) {
        fetchData(endpoint: .details(id: id), completion: completion)
    }
    
    func getPopularMovies(page: Int, completion: @escaping ((Result<PageInfo, Error>) -> Void)) {
        fetchData(endpoint: .popular(page: page), completion: completion)
    }
    
    func discoverMovies(genres: [Genre], page: Int, completion: @escaping ((Result<[MovieList], Error>) -> Void)) {
        let dispatchGroup = DispatchGroup()
        var movieList: [MovieList] = []
        
        genres.forEach { genre in
            dispatchGroup.enter()
            fetchData(endpoint: .discover(genre: genre.rawValue, page: page)) { (result: Result<PageInfo, Error>) in
                switch result {
                case .success(let page):
                    movieList.append(.init(genre: genre, movies: page.movies))
                case .failure:
                    break
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(movieList))
        }
    }
}

