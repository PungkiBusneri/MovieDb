//
//  MyTableViewCell.swift
//  TestMovie
//
//  Created by Pungki Busneri on 06/10/23.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet var imageMovieView: UIImageView!
    @IBOutlet var labelTitleMovie: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelGenre: UILabel!
    
    private var genres: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageMovieView.layer.cornerRadius = 4
    }
    func setupCell(movie: MovieList, genre: [Genre]) {
        labelTitleMovie.text = movie.title
        labelDate.text = dateFormat(from: movie.releaseDate)
        imageMovieView.setImage(with: ImageUrl.Poster + movie.posterPath)
        
        for id in movie.genreIDS {
            for (index, item) in genre.enumerated() {
                if id == item.id {
                    self.genres.append(genre[index].name)
                }
            }
        }
        labelGenre.text = self.genres.joined(separator: ", ")
    }
}


