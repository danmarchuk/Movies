//
//  SearchMovieNetworkManager.swift
//  Movies
//
//  Created by Данік on 14/10/2023.
//

import Foundation
import Alamofire

class SearchMovieNetworkManager {
    
    func fetchAMovieOrTv(withTitle title: String, movieOrTv: String, completion: @escaping ([MovieOrTvInfo]) -> Void) {
        let url = "https://api.themoviedb.org/3/search/\(movieOrTv)"
        let apiKey = "b029500d19bf2e8230d0496bad4302ab"
        
        let fullURL = "\(url)?api_key=\(apiKey)&query=\(title)"
        
        // Use Alamofire to fetch the data
        AF.request(fullURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let jsonDict = value as? [String: Any],
                   let results = jsonDict["results"] as? [[String: Any]] {
                    
                    var contentList = [MovieOrTvInfo]()
                    
                    for result in results {
                        let id = result["id"] as? Int ?? 0
                        let title = result["title"] as? String ?? result["name"] as? String ?? ""
                        print(title)
                        let poster = result["poster_path"] as? String ?? ""
                        let posterPath = "https://image.tmdb.org/t/p/w500\(poster)"
                        let rating = result["vote_average"] as? Double ?? 0.0
                        let mediaType = result["media_type"] as? String ?? ""
                        let description = result["overview"] as? String ?? ""
                        
                        var isMovie: Bool?
                        
                        if fullURL.contains("all") {
                            if mediaType == "movie" {
                                isMovie = true
                            } else if mediaType == "tv" {
                                isMovie = false
                            }
                        } else if fullURL.contains("tv") {
                            isMovie = false
                        } else if fullURL.contains("movie") {
                            isMovie = true
                        }
                        
                        guard let unwrappedIsMovie = isMovie else {return}
                        
                        let content = MovieOrTvInfo(posterUrl: posterPath, title: title, rating: rating, id: id, movie: unwrappedIsMovie, description: description)
                        contentList.append(content)
                    }
                    
                    completion(contentList)
                    
                } else {
                    print("Invalid JSON structure")
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
