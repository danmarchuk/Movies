//
//  ActorFullInfo.swift
//  Movies
//
//  Created by Данік on 22/09/2023.
//

import Foundation

struct ActorFullInfo: Codable {
    var id: Int
    var imageUrl: String
    var nameAndSurname: String
    var job: String
    var biography: String
    var credits: [ActingInfo]
}

struct ActingInfo: Codable {
    var posterUrl: String
    var title: String
    var id: Int
    var isMovie: Bool
    var releaseDate: String
    var character: String
    var episodeCount: Int
}
