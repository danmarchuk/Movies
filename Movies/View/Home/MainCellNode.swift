//
//  HomeMainCellNode.swift
//  Movies
//
//  Created by Данік on 29/09/2023.
//

import Foundation
import AsyncDisplayKit
import LUNSegmentedControl
import BetterSegmentedControl
import TTSegmentedControl

final class MainCellNode: ASCellNode {
    
    private let sectionNameLabel = ASTextNode()
    private let seeAllLabel = ASTextNode()
    let innerHorizontalCollectionNode = InnerHorizontalCollectionNode()
    let segmentedControl = CustomSegmentedControlNode(items: [])
    var categories: [Category] = []


    init(withSection section: Section) {
        super.init()
        automaticallyManagesSubnodes = true
        let title = section.name
        let movies = section.categories[0].movies
        categories = section.categories
        configure(withTitle: title, withContents: movies)
        
        segmentedControl.segmentedControl.delegate = self
        
        var categoryNames: [String] = []
        for category in section.categories {
            categoryNames.append(category.name)
        }
        segmentedControl.updateValues(withItems: categoryNames)
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
        innerHorizontalCollectionNode.node.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.height/1.3)

        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        
        segmentedControl.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.height/7.5)
        let segmentedControlSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: segmentedControl)
        
        let horizontalStack = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 8,
                                                justifyContent: .start,
                                                alignItems: .center,
                                                children: [sectionNameLabel, spacer, seeAllLabel])
        
        let horizontalStackSpec =  ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: horizontalStack)
        
        let verticalStack = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 16,
                                              justifyContent: .start,
                                              alignItems: .stretch,
                                              children: [horizontalStackSpec, segmentedControlSpec , innerHorizontalCollectionNode.node])

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return ASInsetLayoutSpec(insets: insets, child: verticalStack)
    }
}

extension MainCellNode: TTSegmentedControlDelegate {
    func segmentedView(_ view: TTSegmentedControl, didEndAt index: Int) {
        innerHorizontalCollectionNode.moviesOrTvs = categories[index].movies
    }
}

