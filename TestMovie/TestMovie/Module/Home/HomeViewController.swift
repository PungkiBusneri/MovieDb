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
                self.movieList = result
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
