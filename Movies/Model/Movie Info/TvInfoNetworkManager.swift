//
//  TvInfoNetworkManager.swift
//  Movies
//
//  Created by Данік on 23/09/2023.
//

import Foundation
import Alamofire

import Alamofire

class TvInfoNetworkManager {
    
    func fetchATvSeries(withMovieId id: String, completion: @escaping (MovieOrTVFullInfo?) -> Void) {
        let url = "https://api.themoviedb.org/3/tv/"
        let apiKey = "b029500d19bf2e8230d0496bad4302ab"
        
        let fullURL = "\(url)\(id)?api_key=\(apiKey)&append_to_response=videos,release_dates,credits,content_ratings"
        
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

                let title = jsonDict["name"] as? String ?? ""
                let releaseYear = (jsonDict["first_air_date"] as? String)?.prefix(4) ?? ""
                var rating = jsonDict["vote_average"] as? Double ?? 0.0
                rating = rating * 10
                // length
                guard let lastEpisodeToAirDict = jsonDict["last_episode_to_air"] as? [String: Any] else {return}
                let length = lastEpisodeToAirDict["runtime"] as? Int ?? 0

                let poster = jsonDict["backdrop_path"] as? String ?? ""
                let posterUrl = "https://www.themoviedb.org/t/p/w500/\(poster)"
                let genres = (jsonDict["genres"] as? [[String: Any]])?.compactMap { $0["name"] } ?? []
                
                guard let genresUnwrapped = genres as? [String] else {return}
                
                let description = jsonDict["overview"] as? String ?? "No description"
                let id = jsonDict["id"] as? Int ?? 0
                
                let videos = jsonDict["videos"] as? [String: [[String: Any]]]
                let videoUrls = videos?["results"]?.compactMap {
                    "https://www.youtube.com/watch?v=" + ($0["key"] as? String ?? "")
                } ?? []
                
                // Age Rating
                let resultsInsideReleaseDatesDict = jsonDict["content_ratings"] as? [String: [[String: Any]]]
                var usRating = ""
                if let resultsArray = resultsInsideReleaseDatesDict?["results"] as? [[String: Any]] {
                    for result in resultsArray {
                        if result["iso_3166_1"] as? String == "US" {
                            usRating = result["rating"] as? String ?? ""
                            break
                        }
                    }
                } else {
                    usRating = ""
                }
                
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
                
                // CurrentSeasonDetails
                let seasonNumber = lastEpisodeToAirDict["season_number"] as? Int ?? 0
                let airYear = (lastEpisodeToAirDict["air_date"] as? String)?.prefix(4) ?? ""
                let episodeNumber = lastEpisodeToAirDict["episode_number"] as? Int ?? 0
                let currentSeasonPoster = jsonDict["poster_path"] as? String ?? ""
                let currentSeasonPosterUrl = "https://www.themoviedb.org/t/p/w500\(currentSeasonPoster)"
                let currentSeasonDetails = CurrentSeason(seasonNumber: seasonNumber, airYear: String(airYear), episodeNumber: episodeNumber, posterUrl: currentSeasonPosterUrl)
                
                let movieInfo = MovieOrTVFullInfo(
                    title: title,
                    releaseYear: String(releaseYear),
                    ageRestriction: usRating,
                    rating: rating,
                    length: length,
                    posterUrl: posterUrl,
                    genres: genresUnwrapped,
                    description: description,
                    currentSeasonDetails: currentSeasonDetails,
                    id: id,
                    videoUrls: videoUrls,
                    isMovie: false, actors: actors
                )
                completion(movieInfo)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
