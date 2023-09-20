//
//  CastHorizontalController.swift
//  Movies
//
//  Created by Данік on 19/09/2023.
//

import Foundation
import UIKit

class CastHorizontalController: BaseListController {
    var actors: [ActorShortInfo] = [ActorShortInfo(imageUrl: "https://image.tmdb.org/t/p/w500/euDPyqLnuwaWMHajcU3oZ9uZezR.jpg", nameAndSurname: "Margot Robbie", character: "Barbie", id: 234352), ActorShortInfo(imageUrl: "https://image.tmdb.org/t/p/w500/lyUyVARQKhGxaxy0FbPJCQRpiaW.jpg", nameAndSurname: "Ryan Gosling", character: "Ken", id: 30614), ActorShortInfo(imageUrl: "https://image.tmdb.org/t/p/w500/dhiUliLE7dFaqj5BKNQ6x7Wm9uR.jpg", nameAndSurname: "America Ferrera", character: "Gloria", id: 59174), ActorShortInfo(imageUrl: "https://image.tmdb.org/t/p/w500/2cNetzianFcxPQbyOQnkAIkKUZE.jpg", nameAndSurname: "Kate McKinnon", character: "Barbie", id: 1240487)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        collectionView.register(ActorCell.self, forCellWithReuseIdentifier: ActorCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 10
            layout.scrollDirection = .horizontal
        }
    }
}

// MARK: - Delegate and Datasource methods
extension CastHorizontalController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCell.identifier, for: indexPath) as? ActorCell else {
            return UICollectionViewCell()
        }
        cell.configure(withActor: actors[indexPath.row])
        print("cell is being configured")
        return cell
    }
}

extension CastHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width / 4, height: view.frame.height)
    }
}
