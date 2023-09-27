//
//  ProfileViewController.swift
//  Movies
//
//  Created by Данік on 18/09/2023.
//

import Foundation

class ProfileViewController: UIViewController {
    
    let searchScreen = SearchScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchScreen
    }
}
