//
//  MovieModel.swift
//  TestMovie
//
//  Created by Pungki Busneri on 09/10/23.
//

import Foundation

struct MovieModel {
    let backdropPath: String
    let genres: [Genre]
    let id: Int
    let originalTitle, overview: String
    let runtime: Int
    let title: String

    init(data: [String : Any]) {
        backdropPath = data["backdrop_path"] as? String ?? ""
        id = data["id"] as? Int ?? 0
        originalTitle = data["original_title"] as? String ?? ""
        overview = data["overview"] as? String ?? ""
        runtime = data["runtime"] as? Int ?? 0
        title = data["title"] as? String ?? ""
        let genres = data["genres"] as? [[String:Any]] ?? nil
        var dataGenres = [Genre]()
        
        if genres != nil {
            for genre in genres! {
                let id = genre["id"] as? Int ?? 0
                let name = genre["name"] as? String ?? ""
                let genreData = Genre(id: id, name: name)
                dataGenres.append(genreData)
            }
        }
        self.genres = dataGenres
    }
}

struct Cast {
    let id: Int
    let name: String
    let originalName: String
    let profilePath: String
    let character: String
    
    init(data: [String : Any]) {
        id = data["id"] as? Int ?? 0
        name = data["name"] as? String ?? ""
        originalName = data["original_name"] as? String ?? ""
        profilePath = data["profile_path"] as? String ?? ""
        character = data["character"] as? String ?? ""
    }
}
