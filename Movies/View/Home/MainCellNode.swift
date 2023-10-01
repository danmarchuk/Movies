//
//  HomeMainCellNode.swift
//  Movies
//
//  Created by Данік on 29/09/2023.
//

import Foundation
import AsyncDisplayKit
import LUNSegmentedControl
import SnapKit

class MainCellNode: ASCellNode {
    
    private let sectionNameLabel = ASTextNode()
    private let seeAllLabel = ASTextNode()
    let innerHorizontalCollectionNode = InnerHorizontalCollectionNode()


    init(withTitle title: String, withContents moviesOrTvs: [MovieOrTvInfo]) {
        super.init()
        automaticallyManagesSubnodes = true
        configure(withTitle: title, withContents: moviesOrTvs)
    }
    
    func configure(withTitle title: String, withContents moviesOrTvs: [MovieOrTvInfo]) {
        sectionNameLabel.attributedText = NSAttributedString(string: title, attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
            .foregroundColor: K.searchBlack
        ])
        seeAllLabel.attributedText = NSAttributedString(string: "See all", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.seeAllColor
        ])
        innerHorizontalCollectionNode.moviesOrTvs = moviesOrTvs
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        
        innerHorizontalCollectionNode.style.flexGrow = 1.0
        let cellHeight: CGFloat = 100 // Assuming a fixed height for the cells
        let collectionHeight = cellHeight * CGFloat(innerHorizontalCollectionNode.moviesOrTvs.count)
        innerHorizontalCollectionNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: collectionHeight)
        
        let horizontalStack = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 0,
                                                justifyContent: .start,
                                                alignItems: .center,
                                                children: [sectionNameLabel, spacer, seeAllLabel])
        
        let verticalStack = ASStackLayoutSpec(direction: .vertical,
                                                spacing: 0,
                                                justifyContent: .start,
                                                alignItems: .center,
                                                children: [horizontalStack, innerHorizontalCollectionNode])

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return ASInsetLayoutSpec(insets: insets, child: verticalStack)
    }
    
}

