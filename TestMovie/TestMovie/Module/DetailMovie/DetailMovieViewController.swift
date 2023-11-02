//
//  DetailMovieViewController.swift
//  TestMovie
//
//  Created by Pungki Busneri on 10/10/23.
//

import UIKit

class DetailMovieViewController: UIViewController, UICollectionViewDelegate{
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDurationMovie: UILabel!
    @IBOutlet var labelHD: UILabel!
    @IBOutlet var labelGenreMovie: UILabel!
    @IBOutlet var labelMovieDesc: UILabel!
    @IBOutlet var myCollectionView: UICollectionView!
    
    
    var id: Int?
    private var castList = [Cast]()
    private var cellIdentifier = "MyCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpComponent()
        getDataCreditsList(movieId: id ?? 0)
        getDataMovieDetail(movieId: id ?? 0)
        
    }
    func setUpComponent() {
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    @IBAction func didTapButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension DetailMovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCollectionViewCell
        cell.setupCell(data: self.castList[indexPath.row])
        return cell
    }
}
extension DetailMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width/4) - (-8), height: 124)
    }
}
extension DetailMovieViewController {
    public func getDataMovieDetail(movieId: Int) {
        MovieManager.movieManagerHandler(movieId: movieId) { data, error, statusCode in
            
            if error != nil {
                
            } else {
                guard let result = data else { return }
                self.setupLayout(data: result)
            }
        }
    }
    private func getDataCreditsList(movieId: Int) {
        MovieManager.creditsListHandler(movieId: movieId) { data, error, statusCode in
            
            if error != nil {
                
            } else {
                guard let result = data else { return }
                self.castList = result
                self.myCollectionView.reloadData()
            }
        }
    }
    func setupLayout(data: MovieModel?) {
        if let movie = data {
            self.labelGenreMovie.text = "\(movie.genres.map({$0.name}).joined(separator: ", "))"
            self.labelTitle.text = movie.title
            self.labelMovieDesc.text = movie.overview
            self.movieImage.setImage(with: ImageUrl.backdrop + movie.backdropPath)
            self.labelDurationMovie.text = calculateTime(TimeInterval(movie.runtime))
        }
    }
}
