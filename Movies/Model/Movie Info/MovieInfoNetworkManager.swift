//
//  MovieInfoNetworkManager.swift
//  Movies
//
//  Created by Данік on 22/09/2023.
//

import Foundation
import Alamofire

class MovieInfoNetworkManager {
    
    func fetchAMovie(withMovieId id: String, completion: @escaping (MovieOrTVFullInfo?) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/"
        let apiKey = "b029500d19bf2e8230d0496bad4302ab"
        
        let fullURL = "\(url)\(id)?api_key=\(apiKey)&append_to_response=videos,release_dates,credits"
        
        AF.request(fullURL).responseJSON { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonDict = jsonResponse as? [String: Any] else {
                    completion(nil)
                    return
                }

                let title = jsonDict["original_title"] as? String ?? ""
                let releaseYear = (jsonDict["release_date"] as? String)?.prefix(4) ?? ""
                var rating = jsonDict["vote_average"] as? Double ?? 0.0
                let length = jsonDict["runtime"] as? Int ?? 0
                let poster = jsonDict["backdrop_path"] as? String ?? ""
                let posterUrl = "https://www.themoviedb.org/t/p/w500/\(poster)"
                let genres = (jsonDict["genres"] as? [[String: Any]])?.compactMap { $0["name"] } ?? []
                
                guard let genresUnwrapped = genres as? [String] else {return}
                
                let description = jsonDict["overview"] as? String ?? ""
                let id = jsonDict["id"] as? Int ?? 0
                
                let videos = jsonDict["videos"] as? [String: [[String: Any]]]
                let videoUrls = videos?["results"]?.compactMap {
                    "https://www.youtube.com/watch?v=" + ($0["key"] as? String ?? "")
                } ?? []
                
                let releaseDates = jsonDict["release_dates"] as? [String: [[String: Any]]]
                let usReleaseDates = releaseDates?["results"]?.first(where: { ($0["iso_3166_1"] as? String) == "US" })

                let restriction = (usReleaseDates?["release_dates"] as? [[String: Any]])?.first?["certification"] ?? ""
                guard let ageRestriction = restriction as? String else {return}
                
                let credits = jsonDict["credits"] as? [String: [[String: Any]]]
                let names = credits?["cast"]?.compactMap({ ($0["name"]) as? String
                }) ?? []
                let ids = credits?["cast"]?.compactMap({ ($0["id"]) as? Int
                }) ?? []
                let characters = credits?["cast"]?.compactMap({ ($0["character"]) as? String
                }) ?? []
                let actorImageUrls = credits?["cast"]?.compactMap {
                    "https://www.themoviedb.org/t/p/w500/" + ($0["profile_path"] as? String ?? "")
                } ?? []
                
                var actors: [ActorShortInfo] = []
                
                if names.count == ids.count && names.count == characters.count && names.count == actorImageUrls.count {
                    for i in 0..<names.count {
                        let actor = ActorShortInfo(
                            imageUrl: actorImageUrls[i],
                            nameAndSurname: names[i],
                            character: characters[i],
                            id: ids[i]
                        )
                        actors.append(actor)
                    }
                } else {
                    // Handle inconsistencies in data if needed
                    print("Data inconsistency detected!")
                }
                
                let movieInfo = MovieOrTVFullInfo(
                    title: title,
                    releaseYear: String(releaseYear),
                    ageRestriction: ageRestriction,
                    rating: rating,
                    length: length,
                    posterUrl: posterUrl,
                    genres: genresUnwrapped,
                    description: description,
                    currentSeasonDetails: nil,
                    id: id,
                    videoUrls: videoUrls,
                    isMovie: true, actors: actors
                )
                completion(movieInfo)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}

