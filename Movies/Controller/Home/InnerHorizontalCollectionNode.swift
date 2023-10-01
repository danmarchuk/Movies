//
//  InnerHorizontalViewControllerNode.swift
//  Movies
//
//  Created by Данік on 29/09/2023.
//

import Foundation
import AsyncDisplayKit

class InnerHorizontalCollectionNode: ASCollectionNode, ASCollectionDataSource, ASCollectionDelegate {
    
    var moviesOrTvs: [MovieOrTvInfo] = [] {
        didSet {
            reloadData()
        }
    }
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: flowLayout, layoutFacilitator: nil)
        self.delegate = self
        self.dataSource = self
        self.alwaysBounceHorizontal = true
        self.backgroundColor = .white
    }
    
    // MARK: - ASCollectionDataSource
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return moviesOrTvs.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let movie = moviesOrTvs[indexPath.item]
        let cellNode = InnerCellNode(movie: movie)
        return cellNode
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: collectionNode.bounds.width / 3, height: collectionNode.bounds.height)
        return ASSizeRange(min: size, max: size)
    }
    
    // MARK: - ASCollectionDelegate
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        // Handle cell selection if needed
    }
}
