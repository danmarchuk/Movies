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
    let searchScreen = SearchInnerCell()
    let searchCell = SearchMainCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view = searchCell
        setupTheCollectionView()

    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()

    func setupTheCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMainCell.identifier, for: indexPath) as? SearchMainCell else {
            return UICollectionViewCell()
        }
        guard let image = UIImage(named: "welcomeScreenBackgroundImage") else {return UICollectionViewCell()}
        cell.configure(withTitle: <#T##String#>, withSegmentedControl: <#T##[String]#>, withMovies: <#T##[Movie]#>)
        return cell
    }
    
    
}

