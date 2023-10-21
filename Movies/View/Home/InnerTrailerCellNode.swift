//
//  InnerTrailerCellNode.swift
//  Movies
//
//  Created by Данік on 21/10/2023.
//

import AsyncDisplayKit
import MBCircularProgressBar
import SDWebImage

class InnerTrailerCellNode: ASCellNode {
    
    static let identifier = "SearchInnerCell"
    
    let moviePoster = ASNetworkImageNode().apply {
        $0.cornerRadius = 15
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
    }
    
    var playButton = ASButtonNode().apply {
        $0.setImage(UIImage(named: "playButtonImage"), for: .normal)
    }
    
    let moviePosterAndPlayButtonContainer = ASDisplayNode()
        
    let titleLabel: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Movie name", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.titleGray
        ])
        node.maximumNumberOfLines = 2
        return node
    }()
    
    let sloganLabel: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "66%", attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.percentageGray
        ])
        return node
    }()
    
    init(movie: MovieOrTvInfo) {
        super.init()
        automaticallyManagesSubnodes = true
        configure(withMovie: movie)
    }
    
    func configure(withMovie movie: MovieOrTvInfo) {
        moviePoster.url = URL(string: movie.posterUrl)
        titleLabel.attributedText = NSAttributedString(string: movie.title, attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.titleGray
        ])

        sloganLabel.attributedText = NSAttributedString(string: "Slogan", attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.percentageGray
        ])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        moviePoster.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.height / 1.5)
        
        
        
        let mainVerticalStack = ASStackLayoutSpec.vertical()
        mainVerticalStack.children = [moviePoster, titleLabel, sloganLabel]
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: mainVerticalStack)
    }
}


