//
//  HomeViewControllerNode.swift
//  Movies
//
//  Created by Данік on 30/09/2023.
//

import Foundation
import AsyncDisplayKit


class HomeViewControllerNode: ASDKViewController<HomeMainDisplayNode> {
    let homeScreen = HomeMainDisplayNode()

    var sections: [Section] = []

    // We initialize ASViewController with our node
    override init() {
        super.init(node: homeScreen)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData {
            self.node.verticalCollectionNode.sections = self.sections
        }
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func fetchData(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        // popular movies
        var popularStreaming : [MovieOrTvInfo] = []
        var popularOnTv : [MovieOrTvInfo] = []
        var forRent : [MovieOrTvInfo] = []
        var popularInTheatre : [MovieOrTvInfo] = []
        // trending movies
        var trendingDay : [MovieOrTvInfo] = []
        var trendingWeek : [MovieOrTvInfo] = []
        // latest movies and tv shows
        var freeMovies : [MovieOrTvInfo] = []
        var freeTvs : [MovieOrTvInfo] = []
        // trailers
        var trailersStreaming: [MovieOrTvInfo] = []
        var trailersOnTv: [MovieOrTvInfo] = []
        var trailersForRent: [MovieOrTvInfo] = []
        var trailersInTheatres: [MovieOrTvInfo] = []
        
        let networkManager = HomeNetworkManager()
                    
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/tv/popular") { contents in
            popularStreaming = contents
            print(contents)
            group.leave()
        }
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/tv/on_the_air") { contents in
            popularOnTv = contents
            trailersOnTv = contents
            group.leave()
        }
        
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/tv/top_rated") { contents in
            forRent = contents
            trailersForRent = contents
            group.leave()
        }
        
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/movie/now_playing") { contents in
            popularInTheatre = contents
            trailersInTheatres = contents
            group.leave()
        }
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/trending/all/day") { contents in
            trendingDay = contents
            group.leave()
        }
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/trending/all/week") { contents in
            trendingWeek = contents
            group.leave()
        }
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/movie/top_rated") { contents in
            freeMovies = contents
            group.leave()
        }
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/tv/airing_today" ) { contents in
            freeTvs = contents
            group.leave()
        }
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/movie/upcoming" ) { contents in
            trailersStreaming = contents
            group.leave()
        }
        
        group.notify(queue: .main) {
            // categories popular
            let popularStreamingCategory = Category(name: "Streaming", movies: popularStreaming)
            let popularOnTvCategory = Category(name: "On TV", movies: popularOnTv)
            let popularForRentCategory = Category(name: "For Rent", movies: forRent)
            let popularInTheatreCategory = Category(name: "In Theatre", movies: popularInTheatre)
            // trending
            let trendingDayCategory = Category(name: "Day", movies: trendingDay)
            let trendingWeekCategory = Category(name: "Week", movies: trendingWeek)
            // trailers
            let trailersStreamingCategory = Category(name: "Streaming", movies: trailersStreaming)
            let trailersOnTvCategory = Category(name: "On TV", movies: trailersOnTv)
            let trailersForRentCategory = Category(name: "For Rent", movies: trailersForRent)
            let trailersInTheatreCategory = Category(name: "In Theatre", movies: trailersInTheatres)
            // free
            let freeMoviesCategory = Category(name: "Movies", movies: freeMovies)
            let freeTvShowsCategory = Category(name: "TV Shows", movies: freeTvs)
            
            // sections
            let popularSection = Section(name: "What's Popular", categories: [popularStreamingCategory, popularOnTvCategory, popularForRentCategory, popularInTheatreCategory])
            let trailersSection = Section(name: "Latest Trailers", categories: [trailersStreamingCategory, trailersOnTvCategory, trailersForRentCategory, trailersInTheatreCategory])
            let freeSection = Section(name: "Free To Watch", categories: [freeMoviesCategory, freeTvShowsCategory])
            let trendingSection = Section(name: "Trending", categories: [trendingDayCategory, trendingWeekCategory])

            self.sections.append(popularSection)
            self.sections.append(freeSection)
            self.sections.append(trailersSection)
            self.sections.append(trendingSection)

            completion()
        }
    }
}


