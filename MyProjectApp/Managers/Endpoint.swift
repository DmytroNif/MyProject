//
//  Endpoint.swift
//  MyProjectApp
//
//  Created by admin on 29/01/2024.
//


import Alamofire
import Foundation

enum Endpoint: URLRequestConvertible {
    case discover(genre: Int, page: Int)
    case popular(page: Int)
    case details(id: Int)
    case discovertv(genre: Int, page: Int)
    case detailsTV(id: Int)
    
    case search(query: String)
    case searchTV(query: String)
    
    var path: String {
        switch self {
        case .discover:
            return "/discover/movie"
        case .popular:
            return "/discover/movie"
        case .details(let id):
            return "/movie/\(id)"
        case .discovertv:
            return "/discover/tv"
        case .search:
            return "/search/movie"
        case .searchTV:
            return "/search/tv"
        case .detailsTV(let id):
            return "/tv/\(id)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [URLQueryItem] {
        var parameters: [URLQueryItem] = []
        switch self {
        case .discover(let genre, let page):
            parameters = [
                .init(name: "page", value: "\(page)"),
                .init(name: "with_genres", value: "\(genre)")
            ]
        case .popular(let page):
            parameters = [
                .init(name: "include_adult", value: "false"),
                .init(name: "include_video", value: "true"),
                .init(name: "language", value: "en"),
                .init(name: "sort_by", value: "popularity.desc"),
                .init(name: "page", value: "\(page)"),
            ]
        case .details:
            parameters = [
                .init(name: "append_to_response", value: "videos")
            ]
        case .discovertv(page: let page):
            parameters = [
                .init(name: "page", value: "\(page)")
                ]
        case .detailsTV(id: let id):
            parameters = [
                .init(name: "append_to_response", value: "videos")
            ]
        case .search(let query):
            parameters = [
                .init(name: "query", value: query)
            ]
        case .searchTV(let query):
            parameters = [
                .init(name: "query", value: query)
            ]

        }
        
        parameters.append(.init(name: "api_key", value: Constant.apiKey))
        return parameters
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseURL = try Constant.baseURL.asURL()
        let fullURL = baseURL.appendingPathComponent(path)
        
        var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters
        
        var request = URLRequest.init(url: try components?.asURL() ?? fullURL)
        request.httpMethod = method.rawValue
        
        return request
    }
}

