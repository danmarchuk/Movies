//
//  SearchActorNetworkManager.swift
//  Movies
//
//  Created by Данік on 14/10/2023.
//

import Foundation
import Alamofire

class SearchActorNetworkManager {
    
    func fetchPeople(withName name: String, completion: @escaping ([PersonInfo]) -> Void) {
        let url = "https://api.themoviedb.org/3/search/person"
        let apiKey = "b029500d19bf2e8230d0496bad4302ab"
        
        let fullURL = "\(url)?api_key=\(apiKey)&query=\(name)"
        
        // Use Alamofire to fetch the data
        AF.request(fullURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let jsonDict = value as? [String: Any],
                   let results = jsonDict["results"] as? [[String: Any]] {
                    
                    var actorList = [PersonInfo]()
                    
                    for result in results {
                        let id = result["id"] as? Int ?? 0
                        let job = result["known_for_department"] as? String ?? ""
                        let name = result["name"] as? String ?? ""
                        
                        let poster = result["profile_path"] as? String ?? ""
                        let posterPath = "https://image.tmdb.org/t/p/w500\(poster)"
                        
                        let content = PersonInfo(id: id, imageUrl: posterPath, nameAndSurname: name, job: job, lastProject: "MAGAd")
                        actorList.append(content)
                    }
                    
                    completion(actorList)
                    
                } else {
                    print("Invalid JSON structure")
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
