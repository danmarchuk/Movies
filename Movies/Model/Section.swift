//
//  Section.swift
//  Movies
//
//  Created by Данік on 10/09/2023.
//

import Foundation

struct Section {
    var name: String
    var categories: [Category]
}

struct Category {
    var name: String
    var movies: [MovieOrTvInfo]
}
