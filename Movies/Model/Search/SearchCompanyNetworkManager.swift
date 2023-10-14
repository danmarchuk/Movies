//
//  SearchCompanyNetworkManager.swift
//  Movies
//
//  Created by Данік on 14/10/2023.
//

import Foundation
import Alamofire

class SearchCompanyNetworkManager {
    
    func fetchCompanies(withName name: String, completion: @escaping ([Company]) -> Void) {
        let url = "https://api.themoviedb.org/3/search/company"
        let apiKey = "b029500d19bf2e8230d0496bad4302ab"
        
        let fullURL = "\(url)?api_key=\(apiKey)&query=\(name)"
        
        // Use Alamofire to fetch the data
        AF.request(fullURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let jsonDict = value as? [String: Any],
                   let results = jsonDict["results"] as? [[String: Any]] {
                    
                    var listOfCompanies = [Company]()
                    
                    for result in results {
                        let id = result["id"] as? Int ?? 0
                        let name = result["name"] as? String ?? ""
                        let content = Company(name: name, id: id)
                        listOfCompanies.append(content)
                    }
                    
                    completion(listOfCompanies)
                    
                } else {
                    print("Invalid JSON structure")
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
