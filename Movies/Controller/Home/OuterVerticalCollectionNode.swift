//
//  HomeViewControllerNode.swift
//  Movies
//
//  Created by Данік on 28/09/2023.
//

import Foundation
import AsyncDisplayKit

class OuterVerticalCollectionNode: ASDKViewController<ASCollectionNode>, ASCollectionDelegate, ASCollectionDataSource {
    
    var sections: [Section] = [] {
        didSet {
            node.reloadData()
        }
    }
    
    override init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: collectionNode)
        node.view.showsVerticalScrollIndicator = false
        node.view.showsHorizontalScrollIndicator = false
        node.delegate = self
        node.dataSource = self
        node.alwaysBounceHorizontal = true
        node.backgroundColor = .white
        node.view.isScrollEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ASCollectionDataSource
    

    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        // For demonstration purposes, passing an empty array for contents
        let section = sections[indexPath.row]
        
        return MainCellNode(withSection: section)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: collectionNode.bounds.width, height: collectionNode.bounds.height / K.homeMainCellHeightDivider)
        return ASSizeRange(min: size, max: size)
    }
}

