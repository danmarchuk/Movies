//
//  ContentNetworkManager.swift
//  Movies
//
//  Created by Данік on 13/09/2023.
//

import Foundation
import Alamofire

class ContentNetworkManager {
    func fetchContent(from url: String, completion: @escaping ([Content]) -> Void) {
        let apiKey = "b029500d19bf2e8230d0496bad4302ab"
        let fullURL = "\(url)?api_key=\(apiKey)"
        
        // Use Alamofire to fetch the data
        AF.request(fullURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let jsonDict = value as? [String: Any],
                   let results = jsonDict["results"] as? [[String: Any]] {
                    
                    var contentList = [Content]()
                    
                    for result in results {
                        let id = result["id"] as? Int ?? 0
                        let title = result["title"] as? String ?? result["name"] as? String ?? ""
                        let poster = result["poster_path"] as? String ?? ""
                        let posterPath = "https://image.tmdb.org/t/p/w500\(poster)"
                        let rating = result["vote_average"] as? Double ?? 0.0
                        let mediaType = result["media_type"] as? String ?? ""
                        
                        var isMovie = false
                        
                        if url.contains("movie") {
                            isMovie = true
                        } else if url.contains("tv") {
                            isMovie = false
                        } else if url.contains("all") {
                            isMovie = (mediaType == "movie")
                        }
                        
                        let content = Content(posterUrl: posterPath, title: title, rating: rating, id: id, movie: isMovie)
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
