//
//  SearchViewController.swift
//  Movies
//
//  Created by Данік on 18/09/2023.
//

import Foundation

class SearchViewController: UIViewController {
    
    let actor = ActorScreen()
    var contents: [MovieOrTvInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = actor
        fetchData {
            self.actor.knownForController.contents = self.contents
            self.actor.knownForController.collectionView.reloadData()
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
