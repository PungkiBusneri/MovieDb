//
//  HomeViewController.swift
//  TestMovie
//
//  Created by Pungki Busneri on 29/10/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var textFieldSearch: UITextField!
    @IBOutlet var tableViewMovieList: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    private var refreshControl: UIRefreshControl!
    private var genreList = [Genre]()
    private var movieList = [MovieList]()
    private var cellIdentifier = "MyTableViewCell"
    private var originalMovieList = [MovieList]()
    private var hasLoadedInitialMovies = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        getDataMovieList(1)
        getDataGenreList()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    func setupComponent() {
        setupRefreshControl()
        textFieldSearch.addPaddingAndIcon(UIImage.icSearch, padding: 15, isLeftView: false)
        
        tableViewMovieList.delegate = self
        tableViewMovieList.dataSource = self
        
        tableViewMovieList.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        textFieldSearch.delegate = self
        textFieldSearch.attributedPlaceholder = NSAttributedString(
            string: "Search your films here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textFieldSearch.textColor = .white
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        resizeRefreshControl(from: refreshControl)
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        tableViewMovieList.addSubview(refreshControl)
    }
    @objc func handleRefreshControl() {
        getDataMovieList(1)
        refreshControl.endRefreshing()
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailMovieViewController = DetailMovieViewController()
        detailMovieViewController.id = movieList[indexPath.row].id
        navigationController?.pushViewController(detailMovieViewController, animated: true)
    }
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
        cell.setupCell(movie: movieList[indexPath.row], genre: genreList)
        return cell
    }
}

extension HomeViewController {
    private func getDataMovieList(_ page: Int) {
        activityIndicator.startAnimating()
        HomeManager.movieListHandler(page: page) { data, error, statusCode in
            self.activityIndicator.stopAnimating()
            
            if error != nil {
                
            } else {
                guard let result = data else { return }
                
                if !self.hasLoadedInitialMovies {
                    self.originalMovieList = result
                    self.hasLoadedInitialMovies = true
                }
                
                self.movieList = self.textFieldSearch.text?.isEmpty ?? true ? self.originalMovieList: result
                    self.tableViewMovieList.reloadData()
            }
        }
    }
    private func getDataGenreList() {
        activityIndicator.startAnimating()
        HomeManager.genreListhandler { data, error, statusCode in
            self.activityIndicator.stopAnimating()
            
            if error != nil {
                
            } else {
                guard let result = data else { return }
                self.genreList = result
            }
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let currentText = textField.text else  { return true }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let searchKeywords = newText.lowercased().components(separatedBy: " ")
        
        if searchKeywords.isEmpty {
            updateMovieList(originalMovieList)
            
        } else {
            
            let filteredMovies = originalMovieList.filter { movie in
                
                return searchKeywords.allSatisfy { keyword in
                    return movie.title.lowercased().contains(keyword)
                }
            }
            
            updateMovieList(filteredMovies)
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        updateMovieList(originalMovieList)
        return true
    }
    
    private func updateMovieList(_ newMovieList: [MovieList]) {
        if newMovieList.isEmpty {
            
            movieList = originalMovieList
            
        } else {
            
            movieList = newMovieList
            tableViewMovieList.reloadData()
        }
    }
}
