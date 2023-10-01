//
//  SearchViewController.swift
//  Movies
//
//  Created by Данік on 18/09/2023.
//

import Foundation
import AsyncDisplayKit

class SearchViewControllerNode: ASDKViewController<SearchScreenNode>, UISearchBarDelegate {
    let searchScreen = SearchScreenNode()

    var moviesOrTvs: [MovieOrTvInfo] = []

    // We initialize ASViewController with our node
    override init() {
        super.init(node: searchScreen)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchScreen.searchBarNode.searchBar.delegate = self
        fetchData {
            self.node.verticalCollectionNode.moviesOrTvs = self.moviesOrTvs
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
            self.moviesOrTvs = trendingDay
            completion()
        }
    }
}

extension SearchViewControllerNode {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Hide the keyboard
        searchBar.text = "" // Clear the search bar text
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}

