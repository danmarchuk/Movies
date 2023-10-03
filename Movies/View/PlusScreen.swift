//
//  PlusScreen.swift
//  Movies
//
//  Created by Данік on 30/09/2023.
//

import Foundation
import AsyncDisplayKit

final class PlusScreen: ASDisplayNode {
    private let innerHorizontalCollectionNode = InnerHorizontalCollectionNode()
    
    private let labelNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText =
        NSAttributedString(string: "THIS is label", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ])
        return node
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // Set the InnerHorizontalCollectionNode to scroll horizontally
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        innerHorizontalCollectionNode.node.collectionViewLayout = flowLayout
        
        // Stack label and collection node vertically
        let verticalStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10,
            justifyContent: .start,
            alignItems: .stretch,
            children: [labelNode, innerHorizontalCollectionNode.node]
        )
        
        // Give the horizontal collection node a preferred height (for example 200). You can adjust this value.
        innerHorizontalCollectionNode.node.style.height = ASDimension(unit: .points, value: 200)
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: verticalStack)
    }
}
