//
//  NetworkManager.swift
//  MyProjectApp
//
//  Created by admin on 29/01/2024.
//

import Foundation
import Alamofire

class NetworkManager {
    
    typealias ResultClosure<T> = (Result<T, Error>) -> Void
    
    private func fetchData<T: Decodable>(endpoint: Endpoint, completion: @escaping ((Result<T, Error>) -> Void)) {
        AF.request(endpoint)
            .validate()
            .responseDecodable(of: T.self) { response in
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
    
    func getTVDetails(id: Int, completion: @escaping ((Result<TVShowDetails, Error>) -> Void)) {
        fetchData(endpoint: .detailsTV(id: id), completion: completion)
    }
    
    func getPopularMovies(page: Int, completion: @escaping ((Result<PageInfo, Error>) -> Void)) {
        fetchData(endpoint: .popular(page: page), completion: completion)
    }
    
    func getPopularTV(page: Int, completion: @escaping ((Result<TVShowsPageInfo, Error>) -> Void)) {
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
    
    func discoverTVShow(genres: [Genre], page: Int, completion: @escaping ((Result<[TVShowList], Error>) -> Void)) {
        let dispatchGroup = DispatchGroup()
        var tvList: [TVShowList] = []
        
        genres.forEach { genre in
            dispatchGroup.enter()
            fetchData(endpoint: .discovertv(page: page)) { (result: Result<TVShowsPageInfo, Error>) in
                switch result {
                case .success(let page):
                    tvList.append(.init(genre: Genre(rawValue: genre.rawValue) ?? Genre.action, tvShows: page.results ?? [] ))
                case .failure:
                    break
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(tvList))
        }
    }
    
    func searchMovies(query: String, completion: @escaping ResultClosure<Page>) {
        let endpoint = Endpoint.search(query: query)
        fetchData(endpoint: endpoint, completion: completion)
    }
    
    func searchTV(query: String, completion: @escaping ResultClosure<TVPage>) {
        let endpoint = Endpoint.search(query: query)
        fetchData(endpoint: endpoint, completion: completion)
    }
}

struct Page: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TVPage: Decodable {
    let page: Int
    let results: [TVShow]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


