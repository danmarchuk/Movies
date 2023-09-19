//
//  ViewController.swift
//  Movies
//
//  Created by Данік on 25/08/2023.
//

import UIKit
import SnapKit


class HomeViewController: UIViewController {
    var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTheCollectionView()
        fetchData{
            self.collectionView.reloadData()
        }
    }
    
    func fetchData(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        // popular movies
        var popularStreaming : [Content] = []
        var popularOnTv : [Content] = []
        var forRent : [Content] = []
        var popularInTheatre : [Content] = []
        // trending movies
        var trendingDay : [Content] = []
        var trendingWeek : [Content] = []
        // latest movies and tv shows
        var freeMovies : [Content] = []
        var freeTvs : [Content] = []
        // trailers
        var trailersStreaming: [Content] = []
        var trailersOnTv: [Content] = []
        var trailersForRent: [Content] = []
        var trailersInTheatres: [Content] = []
        
        let networkManager = ContentNetworkManager()
                    
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/tv/popular") { contents in
            popularStreaming = contents
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
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(SearchMainCell.self, forCellWithReuseIdentifier: SearchMainCell.identifier)
        return cv
    }()

    func setupTheCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 30
        }
        collectionView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMainCell.identifier, for: indexPath) as? SearchMainCell else {
            return UICollectionViewCell()
        }
        let section = sections[indexPath.row]
        // Extract names of categories in the section
        let categoryNames = section.categories.map { $0.name }
        // Set the category names as the segments for the segmented control
        cell.segmentedControlElements = categoryNames
        
        cell.innerHorizontalCollectionView.contents = section.categories[0].movies // Initial content for demonstration
        
        cell.configure(withTitle: section.name, withContents: section.categories[0].movies)
        cell.innerHorizontalCollectionView.collectionView.reloadData()
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height / 2)
    }
}

