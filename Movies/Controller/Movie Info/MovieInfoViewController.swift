//
//  MovieInfoViewController.swift
//  Movies
//
//  Created by Данік on 19/09/2023.
//

import Foundation
import UIKit

class MovieInfoViewController: UIViewController {
    
    private var backButton: UIBarButtonItem!

    let movieScreen = MovieScreen()
    var contents: [MovieOrTvInfo] = []
    var movieOrTvId: String?
    var isMovie: Bool?
    
    var movieOrTvFullInfo: MovieOrTVFullInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = movieScreen
        fetchData {
            self.movieScreen.recomendationsController.contents = self.contents
            if let movieInfo = self.movieOrTvFullInfo {
                self.movieScreen.configure(withMovieFullInfo: movieInfo)
            }
        }
        setupNavigationBar()
    }
    
    func fetchData(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        var trendingDay : [MovieOrTvInfo] = []
        let networkManager = HomeNetworkManager()
        
        let movieNetworkManager = MovieInfoNetworkManager()
        let tvNetworkManager = TvInfoNetworkManager()
        
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/trending/all/day") { contents in
            trendingDay = contents
            group.leave()
        }
        
        group.enter()
        guard let isMovieUnwrapped = isMovie else {return}
        if isMovieUnwrapped {
            movieNetworkManager.fetchAMovie(withMovieId: movieOrTvId ?? "666") { movieInfo in
                self.movieOrTvFullInfo = movieInfo
                group.leave()
            }
        } else {
            tvNetworkManager.fetchATvSeries(withMovieId: movieOrTvId ?? "666") { tvInfo in
                self.movieOrTvFullInfo = tvInfo
                group.leave()
            }
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
