//
//  GenreCellNode.swift
//  Movies
//
//  Created by Данік on 05/10/2023.
//

import AsyncDisplayKit

final class GenreCellNode: ASCellNode {
    
    let customLabel = ASTextNode()
    
    override init() {
        super.init()
        // Setup default style (this can be modified as needed)
        customLabel.maximumNumberOfLines = 1
        customLabel.truncationMode = .byTruncatingTail
        customLabel.style.alignSelf = .center
        addSubnode(customLabel)
        // Border style
        self.borderWidth = 1.0
        self.cornerRadius = 5.0
        self.borderColor = K.movieScreenBorderColor
    }
    
    func configure(withGenges genres: String) {
        customLabel.attributedText = NSAttributedString(string: genres, attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.movieScreenGray2
        ])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // Here, we're just returning the text node, but you can add padding if necessary.
        // This padding will be inside the border
        let insets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        let insetSpec = ASInsetLayoutSpec(insets: insets, child: customLabel)
        return insetSpec
    }
}


