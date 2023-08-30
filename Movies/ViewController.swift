//
//  ViewController.swift
//  Movies
//
//  Created by Данік on 25/08/2023.
//

import UIKit

class ViewController: UIViewController {
    let launchScreen = MoviesLaunchScreen()
    let welcomeScreen = WelcomeScreen()
    let searchScreen = SearchScreen()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view = searchScreen
    }

}

