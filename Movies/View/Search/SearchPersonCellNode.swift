//
//  SearchPersonCellNode.swift
//  Movies
//
//  Created by Данік on 14/10/2023.
//

import Foundation
import AsyncDisplayKit

class SearchPersonCellNode: ASCellNode {
    
    let moviePoster = ASNetworkImageNode().apply {
        $0.contentMode = .scaleAspectFill
        $0.cornerRadius = 5
        $0.clipsToBounds = true
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
    }
    
    let nameLabel: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.style.flexShrink = 1.0
        return node
    }()
    
    let jobAndLastProjectLabel: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.style.flexShrink = 1.0
        return node
    }()
    
    
    
    let grayDivider = ASDisplayNode().apply {
        $0.backgroundColor = UIColor(cgColor: K.movieScreenBorderColor)
    }

    
    init(info: PersonInfo) {
        super.init()
        automaticallyManagesSubnodes = true
        configure(withActingInfo: info)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        grayDivider.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 1)
        moviePoster.style.preferredSize = CGSize(width: constrainedSize.max.width / 10, height: constrainedSize.max.width / 10 )
        
        let grayDividerSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0), child: grayDivider)
        
        let nameAndJobStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 2,
            justifyContent: .start,
            alignItems: .stretch,
            children: [nameLabel, jobAndLastProjectLabel]
        )
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.spacing = 16
        horizontalStack.children = [moviePoster, nameAndJobStack]

        

        let mainStack = ASStackLayoutSpec.vertical()
        mainStack.spacing = 6
        mainStack.children = [horizontalStack, grayDividerSpec]
        
        let insetLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: mainStack)
        
        return insetLayout
    }
    
    private func configure(withActingInfo info: PersonInfo) {
        moviePoster.url = URL(string: info.imageUrl)
        nameLabel.attributedText = NSAttributedString(string: info.nameAndSurname, attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])
        jobAndLastProjectLabel.attributedText = NSAttributedString(
            string: "\(info.job) • \(info.lastProject)",
            attributes: [
                .font: UIFont(name: "OpenSans-Regular", size: 14)!,
                .foregroundColor: K.darkGrayColor
            ]
        )
    }
}
