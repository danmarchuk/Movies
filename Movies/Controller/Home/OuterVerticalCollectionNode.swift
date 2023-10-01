//
//  HomeViewControllerNode.swift
//  Movies
//
//  Created by Данік on 28/09/2023.
//

import Foundation
import AsyncDisplayKit

class OuterVerticalCollectionNode: ASCollectionNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var sections: [Section] = [] {
        didSet {
            reloadData()
        }
    }
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: flowLayout, layoutFacilitator: nil)
        self.delegate = self
        self.dataSource = self
        view.isScrollEnabled = false
    }
    
    // MARK: - ASCollectionDataSource
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }

    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        // For demonstration purposes, passing an empty array for contents
        let section = sections[indexPath.row]
        print(section.categories[0].movies)
        return MainCellNode(withTitle: section.name, withContents: section.categories[0].movies)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: collectionNode.bounds.width, height: collectionNode.bounds.height / 2.8)
        return ASSizeRange(min: size, max: size)
    }
}

