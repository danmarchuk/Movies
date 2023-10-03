//
//  HomeMainDisplayNode.swift
//  Movies
//
//  Created by Данік on 30/09/2023.
//

import Foundation
import AsyncDisplayKit

class HomeMainDisplayNode: ASDisplayNode {
    private let headerLabel = ASTextNode()
    let verticalCollectionNode: OuterVerticalCollectionNode
    private let scrollNode = ASScrollNode()

    override init() {
        verticalCollectionNode = OuterVerticalCollectionNode()
        super.init()
        backgroundColor = .white
        automaticallyManagesSubnodes = true
        setupHeaderLabel()
    }

    private func setupHeaderLabel() {
        headerLabel.attributedText = NSAttributedString(string: "Header Title", attributes: [
            .font: UIFont(name: "OpenSans-Bold", size: 24)!,
            .foregroundColor: UIColor.black
        ])
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        verticalCollectionNode.style.flexGrow = 1.0
//        verticalCollectionNode.style.flexShrink = 1.0
        
        let cellHeight: CGFloat = constrainedSize.max.height / 4 // Assuming a fixed height for the cells
        let collectionHeight = cellHeight * CGFloat(verticalCollectionNode.sections.count)
        verticalCollectionNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: collectionHeight)
        verticalCollectionNode.style.flexGrow = 1.0

        let verticalStack = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 16,
                                              justifyContent: .start,
                                              alignItems: .stretch,
                                              children: [headerLabel, verticalCollectionNode])

        scrollNode.automaticallyManagesContentSize = true
        scrollNode.automaticallyManagesSubnodes = true
        scrollNode.layoutSpecBlock = { (_, _) -> ASLayoutSpec in
            return verticalStack
        }

        return ASWrapperLayoutSpec(layoutElement: scrollNode)
    }

}