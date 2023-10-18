//
//  HomeMainDisplayNode.swift
//  Movies
//
//  Created by Данік on 30/09/2023.
//

import Foundation
import AsyncDisplayKit

class HomeMainDisplayNode: ASDisplayNode {
    let movieButton = ASButtonNode().apply {
        $0.setTitle("Movie", with: UIFont(name: "OpenSans-SemiBold", size: 14), with: K.searchBlack, for: .normal)
    }
    
    let tvShowsButton = ASButtonNode().apply {
        $0.setTitle("TV Shows", with: UIFont(name: "OpenSans-SemiBold", size: 14), with: K.searchBlack, for: .normal)
    }
    
    let peopleButton = ASButtonNode().apply {
        $0.setTitle("People", with: UIFont(name: "OpenSans-SemiBold", size: 14), with: K.searchBlack, for: .normal)
    }
    
    let moreButton = ASButtonNode().apply {
        $0.setTitle("More", with: UIFont(name: "OpenSans-SemiBold", size: 14), with: K.searchBlack, for: .normal)
    }
    
    let buttons = ["Movies", "TV Shows", "People", "More"]
    let verticalCollectionNode = OuterVerticalCollectionNode()
    private let scrollNode = ASScrollNode()

    override init() {
        super.init()
        backgroundColor = .white
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let cellHeight = Int(verticalCollectionNode.node.bounds.height / K.homeMainCellHeightDivider)
        let totalSpacing: CGFloat = 100 * CGFloat(4) // spacing between cells
        let verticalCollectionNodeHeight = CGFloat(4 * cellHeight) + totalSpacing

        verticalCollectionNode.node.style.preferredSize = CGSize(width: constrainedSize.max.width, height: verticalCollectionNodeHeight)
        verticalCollectionNode.node.style.flexGrow = 1.0
        
        let horizontalButtonStack = ASStackLayoutSpec(direction: .horizontal,
                                                      spacing: 30,
                                                      justifyContent: .spaceAround,
                                                      alignItems: .stretch,
                                                      children: [movieButton, tvShowsButton, peopleButton, moreButton])

        let verticalStack = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 45,
                                              justifyContent: .start,
                                              alignItems: .stretch,
                                              children: [horizontalButtonStack, verticalCollectionNode.node])

        scrollNode.automaticallyManagesContentSize = true
        scrollNode.automaticallyManagesSubnodes = true
        scrollNode.layoutSpecBlock = { (_, _) -> ASLayoutSpec in
            return verticalStack
        }

        return ASWrapperLayoutSpec(layoutElement: scrollNode)
    }

}
