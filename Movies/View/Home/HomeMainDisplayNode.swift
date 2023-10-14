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
        

        verticalCollectionNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.height)
//        verticalCollectionNode.style.flexShrink = 1.0

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
