//
//  HomeManager.swift
//  TestMovie
//
//  Created by Pungki Busneri on 27/10/23.
//

import Foundation

final class HomeManager {
    typealias Completion<T> = (_ data: T?,_ error: String?,_ statusCode: Int?) -> Void
    
    static func movieListHandler(page: Int, completion: @escaping(Completion<[MovieList]>)) {
        NetworkService.request(endpoint: .nowPlaying(page: page)) { data, error, statusCode in
            var movieListData = [MovieList]()
            
            if error != nil {
                completion(nil, error, statusCode)
            } else {
                guard let results = data?["results"].arrayObject as? [[String: Any]] else { return }
                
                for i in results {
                    let movie = MovieList(data: i)
                    movieListData.append(movie)
                }
                completion(movieListData, nil, statusCode)
            }
        }
    }
    static func genreListhandler(completion: @escaping(Completion<[Genre]>)) {
        NetworkService.request(endpoint: .genre) { data, error, statusCode in
            var genrelistData = [Genre]()
            
            if error != nil {
                completion(nil, error, statusCode)
            } else {
                guard let genres = data?["genres"].arrayObject as? [[String: Any]] else { return }
                
                for i in genres {
                    let genre = Genre(data: i)
                    genrelistData.append(genre)
                }
                completion(genrelistData, nil, statusCode)
            }
        }
    }
}
