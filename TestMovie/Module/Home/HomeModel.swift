//
//  HomeModel.swift
//  TestMovie
//
//  Created by Pungki Busneri on 25/10/23.
//

import Foundation
//MARK: - Welcome

struct MovieList {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    init (data: [String: Any]) {
        adult = data["adult"] as? Bool ?? false
        backdropPath = data["backdrop_path"] as? String ?? ""
        genreIDS = data["genre_ids"] as? [Int] ?? []
        id = data["id"] as? Int ?? 0
        originalLanguage = data["original_language"] as? String ?? ""
        originalTitle = data["original_title"] as? String ?? ""
        overview = data["overview"] as? String ?? ""
        popularity = data ["popularity"] as? Double ?? 0
        posterPath = data["poster_path"] as? String ?? ""
        releaseDate = data["release_date"] as? String ?? ""
        title = data["title"] as? String ?? ""
        video = data["video"] as? Bool ?? false
        voteAverage = data["vote_average"] as? Double ?? 0
        voteCount = data["vote_count"] as? Int ?? 0
    }
}
struct Genre {
    let id: Int
    let name: String
    
    internal init (id: Int, name: String) {
        self.id = id
        self.name = name
    }
    init(data: [String : Any]) {
        id = data["id"] as? Int ?? 0
        name = data["name"] as? String ?? ""
    }
}
