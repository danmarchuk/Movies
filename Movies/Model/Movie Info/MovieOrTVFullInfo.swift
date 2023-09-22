//
//  MovieFullInfo.swift
//  Movies
//
//  Created by Данік on 22/09/2023.
//

import Foundation

struct MovieOrTVFullInfo: Codable {
    var title: String
    var releaseYear: String
    var ageRestriction: String
    var rating: Double
    var length: Int
    var posterUrl: String
    var genres: [String]
    var description: String
    var currentSeasonDetails: CurrentSeason?
    var id: Int
    var videoUrls: [String]
    var isMovie: Bool
    var actors: [ActorShortInfo]
}

struct CurrentSeason: Codable {
    var seasonNumber: Int
    var airYear: String
    var episodeNumber: Int
}
