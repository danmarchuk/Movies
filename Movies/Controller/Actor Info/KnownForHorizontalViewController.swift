//
//  KnownForHorizontalViewController.swift
//  Movies
//
//  Created by Данік on 21/09/2023.
//

import Foundation
import UIKit

class KnownForHorizontalViewController: BaseListController {
    var contents: [MovieOrTvInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(KnownForCell.self, forCellWithReuseIdentifier: KnownForCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 10
            layout.scrollDirection = .horizontal
        }
    }
}

// MARK: - Delegate and Datasource methods
extension KnownForHorizontalViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KnownForCell.identifier, for: indexPath) as? KnownForCell else {
            return UICollectionViewCell()
        }
        cell.configure(withMovie: contents[indexPath.row])
        return cell
    }
}

extension KnownForHorizontalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width / 2.5, height: view.frame.height)
    }
}
