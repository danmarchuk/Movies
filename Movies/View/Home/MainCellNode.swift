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
import BetterSegmentedControl

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
        // Use the ASRatioLayoutSpec to define a ratio for the innerHorizontalCollectionNode.
        let ratio = ASRatioLayoutSpec(ratio: 0.7, child: innerHorizontalCollectionNode.node)

        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0

        let horizontalStack = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 8, // Some spacing can be added if needed
                                                justifyContent: .start,
                                                alignItems: .center,
                                                children: [sectionNameLabel, spacer, seeAllLabel])
        
        let horizontalStackSpec =  ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: horizontalStack)
        
        let verticalStack = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 16, // Space between label and collection
                                              justifyContent: .start,
                                              alignItems: .stretch, // Make sure to stretch the items to full width
                                              children: [horizontalStackSpec, ratio]) // Use ratio instead of innerHorizontalCollectionNode.node

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Added some horizontal padding
        return ASInsetLayoutSpec(insets: insets, child: verticalStack)
    }


    
}

