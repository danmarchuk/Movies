//
//  MovieInfoViewController.swift
//  Movies
//
//  Created by Данік on 19/09/2023.
//

import Foundation
import UIKit

class MovieInfoViewController: UIViewController {
    
    let movie = MovieScreen()
    var contents: [MovieOrTvInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = movie
        fetchData {
            self.movie.recomendationsController.contents = self.contents
            self.movie.recomendationsController.collectionView.reloadData()
        }
    }
    
    func fetchData(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        var trendingDay : [MovieOrTvInfo] = []
        let networkManager = HomeNetworkManager()
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/trending/all/day") { contents in
            trendingDay = contents
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.contents = trendingDay
            completion()
        }
    }
}
