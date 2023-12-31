//
//  SearchVerticalTrendingControllerNode.swift
//  Movies
//
//  Created by Данік on 26/09/2023.
//

import Foundation
import AsyncDisplayKit

final class SearchVerticalTrendingControllerNode: ASCollectionNode, ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout {
    
    var moviesOrTvs: [MovieOrTvInfo] = [] {
            didSet {
                reloadData()
            }
        }
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: flowLayout, layoutFacilitator: nil)
        dataSource = self
        delegate = self
        backgroundColor = .white
        view.isScrollEnabled = false
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ASCollectionDataSource methods
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return moviesOrTvs.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let movieOrTv = moviesOrTvs[indexPath.row]
        return {
            let cell = TrendingCellNode(movieOrTv: movieOrTv)
            return cell
        }
    }
    
    // MARK: - ASCollectionDelegateFlowLayout methods
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let itemSize = CGSize(width: collectionNode.bounds.width, height: collectionNode.bounds.height / K.searchTrendingCellHeightDivider)
        return ASSizeRange(min: itemSize, max: itemSize)
    }
}
