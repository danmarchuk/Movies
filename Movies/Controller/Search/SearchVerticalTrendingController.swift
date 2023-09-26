//
//  SearchVerticalTrendingController.swift
//  Movies
//
//  Created by Данік on 23/09/2023.
//

import Foundation
import UIKit

class SearchVerticalTrendingController: BaseListController {
    var contents: [MovieOrTvInfo] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 10
            layout.scrollDirection = .vertical
        }
        collectionView.isScrollEnabled = false
    }
}

// MARK: - Delegate and Datasource methods
extension SearchVerticalTrendingController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCell.identifier, for: indexPath) as? TrendingCell else {
            return UICollectionViewCell()
        }
        cell.configure(withMovieOrTv: contents[indexPath.row])
        return cell
    }
}

extension SearchVerticalTrendingController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 80)
    }
}


