//
//  SearchCompanyCellNode.swift
//  Movies
//
//  Created by Данік on 14/10/2023.
//

import Foundation
import AsyncDisplayKit

class SearchCompanyCellNode: ASCellNode {
    
    let nameLabel: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.style.flexShrink = 1.0
        return node
    }()
    
    let grayDivider = ASDisplayNode().apply {
        $0.backgroundColor = UIColor(cgColor: K.movieScreenBorderColor)
    }

    
    init(info: Company) {
        super.init()
        automaticallyManagesSubnodes = true
        configure(withCompanyInfo: info)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        grayDivider.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 1)
        
        let grayDividerSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0), child: grayDivider)

        let mainStack = ASStackLayoutSpec.vertical()
        mainStack.spacing = 17
        mainStack.children = [nameLabel, grayDividerSpec]
        
        let insetLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: mainStack)
        
        return insetLayout
    }
    
    private func configure(withCompanyInfo info: Company) {
        nameLabel.attributedText = NSAttributedString(string: info.name, attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])
    }
}
