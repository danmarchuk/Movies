//
//  ActorInfoNetworkManager.swift
//  Movies
//
//  Created by Данік on 22/09/2023.
//

import Foundation
import Alamofire

final class ActorInfoNetworkManager {
    
    func fetchAnActor(withPersonId id: String, completion: @escaping (ActorFullInfo?) -> Void) {
        let url = "https://api.themoviedb.org/3/person/"
        let apiKey = "b029500d19bf2e8230d0496bad4302ab"
        let fullURL = "\(url)\(id)?api_key=\(apiKey)&append_to_response=combined_credits"
        
        AF.request(fullURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []) else {
                    completion(nil)
                    return
                }
                
                let decoder = JSONDecoder()
                guard let actorInfo = try? decoder.decode(ActorFullInfoFromAPI.self, from: jsonData) else {
                    completion(nil)
                    return
                }
                
                // Convert ActorFullInfoFromAPI to ActorFullInfo
                let result = ActorFullInfo(
                    id: actorInfo.id,
                    imageUrl: "https://www.themoviedb.org/t/p/w500/\(actorInfo.profile_path ?? "")",
                    nameAndSurname: actorInfo.name,
                    job: actorInfo.known_for_department,
                    biography: actorInfo.biography,
                    credits: actorInfo.combined_credits.cast.map { credit in
                        ActingInfo(
                            posterUrl: "https://www.themoviedb.org/t/p/w500/\(credit.poster_path ?? "")",
                            title: credit.title ?? credit.name ?? "",
                            id: credit.id,
                            isMovie: credit.media_type == "movie",
                            releaseDate: credit.release_date ?? credit.first_air_date ?? "",
                            character: credit.character,
                            episodeCount: credit.episode_count ?? 0
                        )
                    }
                )
                
                completion(result)
            case .failure:
                completion(nil)
            }
        }
    }
}

// Intermediate structures to assist with decoding from API and then converting to the desired structures
struct ActorFullInfoFromAPI: Codable {
    var id: Int
    var profile_path: String?
    var name: String
    var known_for_department: String
    var biography: String
    var combined_credits: CombinedCredits
}

struct CombinedCredits: Codable {
    var cast: [Credit]
}

struct Credit: Codable {
    var poster_path: String?
    var title: String?
    var name: String?
    var id: Int
    var media_type: String
    var release_date: String?
    var first_air_date: String?
    var character: String
    var episode_count: Int?
}
