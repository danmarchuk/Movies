//
//  InnerHorizontalViewController.swift
//  Movies
//
//  Created by Данік on 11/09/2023.
//

import UIKit

class InnerHorizontalViewController: BaseListController {
    var contents: [MovieOrTvInfo] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(HomeInnerCell.self, forCellWithReuseIdentifier: HomeInnerCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 10
            layout.scrollDirection = .horizontal
        }
    }
}

// MARK: - Delegate and Datasource methods
extension InnerHorizontalViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeInnerCell.identifier, for: indexPath) as? HomeInnerCell else {
            return UICollectionViewCell()
        }
        cell.configure(withMovie: contents[indexPath.row])
        return cell
    }
}

extension InnerHorizontalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width / 2.5, height: view.frame.height)
    }
}

// MARK: - didSelectItemAt
extension InnerHorizontalViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieInfoViewController = MovieInfoViewController()
        let chosenMovie = contents[indexPath.row]
        movieInfoViewController.movieOrTvId = String(chosenMovie.id)
        movieInfoViewController.isMovie = chosenMovie.movie
        
        let navController = UINavigationController(rootViewController: movieInfoViewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}
