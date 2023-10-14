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
    var searchSections: [SearchSection] = []

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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchScreen.isSearching = false
        } else {
            searchScreen.isSearching = true
            fetchSearchResults(withQuery: searchText) {
                self.node.searchOuterController.sections = self.searchSections
            }
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func fetchSearchResults(withQuery query: String, completion: @escaping () -> Void) {
        let group = DispatchGroup()
        var sections : [SearchSection] = []
        let networkManager = SearchMovieNetworkManager()
        let actorNetworkManager = SearchActorNetworkManager()
        let companyNetworkManager = SearchCompanyNetworkManager()
        
        group.enter()
        networkManager.fetchAMovieOrTv(withTitle: query, movieOrTv: "movie") { movies in
            let movieSection = SearchSection(sectionName: "Movies", moviesOrTvs: movies)
            sections.append(movieSection)
            group.leave()
        }
        
        group.enter()
        networkManager.fetchAMovieOrTv(withTitle: query, movieOrTv: "tv") { tvs in
            let tvSection = SearchSection(sectionName: "TV Shows", moviesOrTvs: tvs)
            sections.append(tvSection)
            group.leave()
        }

        group.enter()
        actorNetworkManager.fetchPeople(withName: query) { actors in
            let peopleSection = SearchSection(sectionName: "People", actors: actors)
            sections.append(peopleSection)
            group.leave()
        }
        
        group.enter()
        companyNetworkManager.fetchCompanies(withName: query) { companies in
            let companiesSection = SearchSection(sectionName: "Companies", companies: companies)
            sections.append(companiesSection)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.searchSections = sections
            completion()
        }
    }
    
}

