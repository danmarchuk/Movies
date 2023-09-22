//
//  MovieInfoViewController.swift
//  Movies
//
//  Created by Данік on 19/09/2023.
//

import Foundation
import UIKit

// ... [Your previous imports and class definition]

class MovieInfoViewController: UIViewController {
    
    private var backButton: UIBarButtonItem!

    let movie = MovieScreen()
    var contents: [MovieOrTvInfo] = []
    var movieId: String?
    
    var movieFullInfo: MovieOrTVFullInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = movie
        fetchData {
            self.movie.recomendationsController.contents = self.contents
            if let movieInfo = self.movieFullInfo {
                self.movie.configure(withMovieFullInfo: movieInfo)
            }
        }
        setupNavigationBar()
    }
    
    func fetchData(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        var trendingDay : [MovieOrTvInfo] = []
        let networkManager = HomeNetworkManager()
        
        let movieNetworkManager = MovieInfoNetworkManager()
        
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/trending/all/day") { contents in
            trendingDay = contents
            group.leave()
        }
        
        group.enter()
        movieNetworkManager.fetchAMovie(withMovieId: movieId ?? "666") { movieInfo in
            self.movieFullInfo = movieInfo
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.contents = trendingDay
            completion()
        }
    }
    
    func setupNavigationBar() {

        backButton = UIBarButtonItem(image: UIImage(named: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        backButton.accessibilityIdentifier = "backArrowButton"
        
        backButton.tintColor = K.seeAllColor

        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
    
}
