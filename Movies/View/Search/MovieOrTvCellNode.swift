//
//  SearchMovieOrTvCellNode.swift
//  Movies
//
//  Created by Данік on 12/10/2023.
//

import AsyncDisplayKit

final class MovieOrTvCellNode: ASCellNode {
    
    // Texture Nodes
    let moviePoster = ASNetworkImageNode().apply {
        $0.contentMode = .scaleAspectFill
        $0.cornerRadius = 5
        $0.clipsToBounds = true
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
    }
    
    let movieTitleLabel: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.style.flexShrink = 1.0
        return node
    }()
    
    let grayDivider = ASDisplayNode().apply {
        $0.backgroundColor = UIColor(cgColor: K.movieScreenBorderColor)
    }

    init(info: MovieOrTvInfo) {
        super.init()
        automaticallyManagesSubnodes = true
        configure(withActingInfo: info)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        grayDivider.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 1)
        moviePoster.style.preferredSize = CGSize(width: constrainedSize.max.width / 10, height: constrainedSize.max.height - 7)
        let grayDividerSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0), child: grayDivider)
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.spacing = 16
        horizontalStack.children = [moviePoster, movieTitleLabel]
        let mainStack = ASStackLayoutSpec.vertical()
        mainStack.spacing = 6
        mainStack.children = [horizontalStack, grayDividerSpec]
        let insetLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: mainStack)
        return insetLayout
    }
    
    private func configure(withActingInfo info: MovieOrTvInfo) {
        moviePoster.url = URL(string: info.posterUrl)
        movieTitleLabel.attributedText = NSAttributedString(string: info.title, attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])
    }
}
