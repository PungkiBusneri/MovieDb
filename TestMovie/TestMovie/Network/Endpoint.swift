//
//  Endpoint.swift
//  TestMovie
//
//  Created by Pungki Busneri on 27/10/23.
//

import Foundation
import Moya

enum Endpoint {
    case nowPlaying(page: Int)
    case genre
    case movieDetails(movieId: Int)
    case credits(movieId: Int)
}

extension Endpoint {
    var parameters: [String: Any] {
        switch self {
        case .nowPlaying(let page):
            return ["page": page]
        default:
            return[:]
        }
    }
}
extension Endpoint: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return URL(string: Constant.apiBaseUrl)!
        }
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing"
        case .genre:
            return "genre/movie/list"
        case .movieDetails(let movieId):
            return "movie/\(movieId)"
        case .credits(let movieId):
            return "movie/\(movieId)/credits"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .nowPlaying:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let headers = [
            "accept": "aplication/json",
            "Authorization": "Bearer \(Constant.accessToken)"
        ]
        switch self {
        default:
            return headers
        }
    }
}
