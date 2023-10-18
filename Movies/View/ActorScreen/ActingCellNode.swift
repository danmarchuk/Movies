//
//  ActingCellNode.swift
//  Movies
//
//  Created by Данік on 06/10/2023.
//

import AsyncDisplayKit

class ActingCellNode: ASCellNode {
    
    let moviePoster = ASNetworkImageNode().apply {
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
        $0.contentMode = .scaleAspectFill
        $0.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    let movieTitleLabel: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.style.flexShrink = 1.0
        return node
    }()
    
    let numberOfEpisodesLabel: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.style.flexShrink = 1.0
        return node
    }()
    
    let releaseYearLabel: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        return node
    }()
    
    let asLabel: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        return node
    }()
    
    let characterLabel: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        node.style.flexShrink = 1.0
        return node
    }()
    
    let grayDivider = ASDisplayNode().apply {
        $0.backgroundColor = UIColor(cgColor: K.movieScreenBorderColor)
    }

    
    init(info: ActingInfo) {
        super.init()
        automaticallyManagesSubnodes = true
        configure(withActingInfo: info)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        grayDivider.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 1)
        
        let grayDividerSpec = ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: grayDivider)
        
        let stack1 = ASStackLayoutSpec.horizontal()
        stack1.spacing = 0
        stack1.justifyContent = .start
        stack1.alignItems = .start
        stack1.children = [movieTitleLabel, numberOfEpisodesLabel, releaseYearLabel]
        
        let stack2 = ASStackLayoutSpec.horizontal()
        stack2.spacing = 0
        stack2.children = [asLabel, characterLabel]
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.spacing = 2
        verticalStack.children = [stack1, stack2]
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.spacing = 16
        horizontalStack.children = [moviePoster, verticalStack]
        moviePoster.style.preferredSize = CGSize(width: constrainedSize.max.width / 10, height: constrainedSize.max.height - 7)
        

        let mainStack = ASStackLayoutSpec.vertical()
        mainStack.spacing = 6
        mainStack.children = [horizontalStack, grayDividerSpec]
        
        let insetLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: mainStack)
        
        return insetLayout
    }
    
    private func configure(withActingInfo info: ActingInfo) {
        moviePoster.url = URL(string: info.posterUrl)
        movieTitleLabel.attributedText = NSAttributedString(string: info.title, attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])
        
        if info.isMovie {
            numberOfEpisodesLabel.attributedText = nil
        } else {
            let episodeText = info.episodeCount <= 1 ? "\(info.episodeCount) ep" : "\(info.episodeCount) eps"
            numberOfEpisodesLabel.attributedText = NSAttributedString(string: " (\(episodeText))", attributes: [
                .font: UIFont(name: "OpenSans-Regular", size: 14)!,
                .foregroundColor: K.movieScreenDarkBlueTextColor
            ])
        }
        
        releaseYearLabel.attributedText = NSAttributedString(string: " | \(info.releaseDate)", attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.lightGrayColor
        ])
        
        asLabel.attributedText = NSAttributedString(string: "as ", attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.veryLightGraycolor
        ])
        
        characterLabel.attributedText = NSAttributedString(string: info.character, attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.darkGrayColor
        ])
    }
}
