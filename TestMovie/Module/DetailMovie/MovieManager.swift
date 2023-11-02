//
//  MovieManager.swift
//  TestMovie
//
//  Created by Pungki Busneri on 07/10/23.
//

import Foundation
    
final class MovieManager {
    typealias Completion<T> = (_ data: T?,_ error: String?,_ statusCode: Int?) -> Void
    
    static func movieManagerHandler(movieId: Int, completion: @escaping(Completion<MovieModel>)) {
        NetworkService.request(endpoint: .movieDetails(movieId: movieId)) { data, error, statusCode in
            var movieDetailsData: MovieModel?
            
            if error != nil {
                completion(nil, error, statusCode)
            } else {
                guard let response = data?.dictionaryObject else { return }
                movieDetailsData = MovieModel(data: response)
                completion(movieDetailsData, nil, statusCode)
            }
        }
    }
    static func creditsListHandler(movieId: Int, completion: @escaping(Completion<[Cast]>)) {
        NetworkService.request(endpoint: .credits(movieId: movieId)) { data, error, statusCode in
            var castListData = [Cast]()
            
            if error != nil {
                completion(nil, error, statusCode)
            } else {
                guard let cast = data?["cast"].arrayObject as? [[String: Any]] else { return }
                
                for i in cast {
                    let cast = Cast (data: i)
                    castListData.append(cast)
                }
                completion(castListData, nil, statusCode)
            }
        }
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
    
