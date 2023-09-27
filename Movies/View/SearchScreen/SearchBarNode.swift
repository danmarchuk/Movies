//
//  SearchBarNode.swift
//  Movies
//
//  Created by Данік on 26/09/2023.
//

import Foundation
import AsyncDisplayKit

final class SearchBarNode: ASDisplayNode {
    let searchBar = UISearchBar()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        view.addSubview(searchBar)
    }

    override func layout() {
        super.layout()
        searchBar.frame = bounds
    }
}
