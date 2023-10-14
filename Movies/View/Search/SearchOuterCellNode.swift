//
//  SearchOuterCellNode.swift
//  Movies
//
//  Created by Данік on 13/10/2023.
//

import AsyncDisplayKit

class SearchOuterCellNode: ASCellNode {
    
    private let sectionNameLabel = ASTextNode()
    private let seeAllButton = ASButtonNode().apply {
        $0.setImage(UIImage(named: "rightArrow"), for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }
    let innerHorizontalCollectionNode = SearchInnerController()


    init(withSection section: SearchSection) {
        super.init()
        automaticallyManagesSubnodes = true
        
        if let moviesOrTvs = section.moviesOrTvs {
            configure(withTitle: section.sectionName, withContents: moviesOrTvs)
        }
        
        if let actors = section.actors {
            configurePeopleCell(withTitle: section.sectionName, withActors: actors)
        }
        
        if let companies = section.companies {
            configureCompaniesCell(withTitle: section.sectionName, withCompanies: companies)
        }
        
    }
    
    func configure(withTitle title: String, withContents moviesOrTvs: [MovieOrTvInfo]) {
        sectionNameLabel.attributedText = NSAttributedString(string: title, attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.searchBlack
        ])
        innerHorizontalCollectionNode.movieOrTvInfo = moviesOrTvs
    }
    
    func configurePeopleCell(withTitle title: String, withActors actors: [PersonInfo]) {
        sectionNameLabel.attributedText = NSAttributedString(string: title, attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.searchBlack
        ])
        innerHorizontalCollectionNode.peopleInfo = actors
    }
    
    func configureCompaniesCell(withTitle title: String, withCompanies companies: [Company]) {
        sectionNameLabel.attributedText = NSAttributedString(string: title, attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.searchBlack
        ])
        innerHorizontalCollectionNode.companiesInfo = companies
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
                                                children: [sectionNameLabel, spacer, seeAllButton])
        
        let verticalStack = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 16, // Space between label and collection
                                              justifyContent: .start,
                                              alignItems: .stretch, // Make sure to stretch the items to full width
                                              children: [horizontalStack, ratio]) // Use ratio instead of innerHorizontalCollectionNode.node

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30) // Added some horizontal padding
        return ASInsetLayoutSpec(insets: insets, child: verticalStack)
    }


    
}
