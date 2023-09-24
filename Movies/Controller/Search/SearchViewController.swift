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
    let searchScreen = SearchScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchScreen
        fetchData {
            self.searchScreen.verticalCollectionView.contents = self.contents            
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
