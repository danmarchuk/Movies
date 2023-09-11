//
//  InnerHorizontalViewController.swift
//  Movies
//
//  Created by Данік on 11/09/2023.
//

import UIKit

class InnerHorizontalViewController: BaseListController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SearchInnerCell.self, forCellWithReuseIdentifier: SearchInnerCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 10
            layout.scrollDirection = .horizontal
        }
    }
}

// MARK: - Delegate and Datasource methods
extension InnerHorizontalViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        50
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchInnerCell.identifier, for: indexPath) as? SearchInnerCell else {
            return UICollectionViewCell()
        }
        guard let image = UIImage(named: "welcomeScreenBackgroundImage") else {return UICollectionViewCell()}
        cell.configure(withImage: image , withTitle: "Hello", withRating: 12)
        return cell
    }
}

extension InnerHorizontalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width / 2.5, height: view.frame.height)
    }
}


