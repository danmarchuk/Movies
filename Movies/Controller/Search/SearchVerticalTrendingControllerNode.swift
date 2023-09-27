//
//  SearchVerticalTrendingControllerNode.swift
//  Movies
//
//  Created by Данік on 26/09/2023.
//

import Foundation

import AsyncDisplayKit

class SearchVerticalTrendingControllerNode: ASCollectionNode, ASCollectionDataSource, ASCollectionDelegateFlowLayout {
    
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
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = .white
        self.view.isScrollEnabled = false
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
        print("THE CELL IS BEING CONFIGURED")
        return {
            let cell = TrendingCellNode(movieOrTv: movieOrTv)
            return cell
        }
    }
    
    // MARK: - ASCollectionDelegateFlowLayout methods
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let itemSize = CGSize(width: collectionNode.bounds.width, height: 80)
        return ASSizeRange(min: itemSize, max: itemSize)
    }
}
