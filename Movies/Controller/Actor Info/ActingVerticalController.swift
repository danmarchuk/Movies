//
//  ActingVerticalController.swift
//  Movies
//
//  Created by Данік on 21/09/2023.
//

import Foundation
import UIKit

class ActingVerticalController: BaseListController {
    var contents: [ActingInfo] = [ActingInfo(posterUrl: "https://image.tmdb.org/t/p/w500/euDPyqLnuwaWMHajcU3oZ9uZezR.jpg", title: "This is a movie", id: 1111, movie: true, releaseDate: "1990", character: "Obama", episodeCount: 3), ActingInfo(posterUrl: "https://image.tmdb.org/t/p/w500/euDPyqLnuwaWMHajcU3oZ9uZezR.jpg", title: "This is a movie", id: 1111, movie: true, releaseDate: "1990", character: "Obama", episodeCount: 3), ActingInfo(posterUrl: "https://image.tmdb.org/t/p/w500/euDPyqLnuwaWMHajcU3oZ9uZezR.jpg", title: "This is a TV with one episode", id: 1111, movie: false, releaseDate: "1992", character: "Thor", episodeCount: 1), ActingInfo(posterUrl: "https://image.tmdb.org/t/p/w500/euDPyqLnuwaWMHajcU3oZ9uZezR.jpg", title: "This is a TV", id: 1111, movie: false, releaseDate: "1902", character: "Thlkmor", episodeCount: 6)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ActingCell.self, forCellWithReuseIdentifier: ActingCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 10
            layout.scrollDirection = .vertical
        }
    }
}

// MARK: - Delegate and Datasource methods
extension ActingVerticalController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActingCell.identifier, for: indexPath) as? ActingCell else {
            return UICollectionViewCell()
        }
        cell.configure(withActingInfo: contents[indexPath.row])
        return cell
    }
}

extension ActingVerticalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height / 5)
    }
}
