//
//  SearchViewController.swift
//  Movies
//
//  Created by Данік on 18/09/2023.
//

import Foundation

class SearchViewController: UIViewController {
    
    let movie = MovieScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = movie
    }
}
