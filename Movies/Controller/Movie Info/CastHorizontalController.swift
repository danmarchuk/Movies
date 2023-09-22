//
//  CastHorizontalController.swift
//  Movies
//
//  Created by Данік on 19/09/2023.
//

import Foundation
import UIKit

class CastHorizontalController: BaseListController {
    var actors: [ActorShortInfo] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
