//
//  SearchViewController.swift
//  Movies
//
//  Created by Данік on 18/09/2023.
//

import Foundation

class SearchViewController: UIViewController {
    
    let movie = MovieScreen()
    var contents: [Content] = []
    
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
        var trendingDay : [Content] = []
        let networkManager = ContentNetworkManager()
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
