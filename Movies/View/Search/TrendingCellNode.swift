//
//  TrendingCellNode.swift
//  Movies
//
//  Created by Данік on 26/09/2023.
//

import Foundation
import AsyncDisplayKit

class TrendingCellNode: ASCellNode {
    
    let moviePoster = ASNetworkImageNode().apply {
        $0.cornerRadius = 15
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
    }
    
    let movieTitle = ASTextNode().apply {
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
        $0.style.flexShrink = 1.0
        $0.truncationMode = .byTruncatingTail
    }
    
    let movieDescription = ASTextNode().apply {
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
        $0.maximumNumberOfLines = 4
        $0.style.flexShrink = 1.0
        $0.truncationMode = .byTruncatingTail
    }
    
    init(movieOrTv: MovieOrTvInfo) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.configure(withMovieOrTv: movieOrTv)
    }
    
    func configure(withMovieOrTv movieOrTv: MovieOrTvInfo) {
        moviePoster.url = URL(string: movieOrTv.posterUrl)
        movieTitle.attributedText = NSAttributedString(
            string: movieOrTv.title,
            attributes: [
                .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
                .foregroundColor: K.searchBlack
            ]
        )
        movieDescription.attributedText = NSAttributedString(
            string: movieOrTv.description,
            attributes: [
                .font: UIFont(name: "OpenSans-Regular", size: 14)!,
                .foregroundColor: K.darkGrayColor
            ]
        )
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let posterRatioSpec = ASRatioLayoutSpec(ratio: 1.0, child: moviePoster)
        
        posterRatioSpec.style.flexBasis = ASDimensionMakeWithFraction(0.3)


        let titleAndDescriptionStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 4,
            justifyContent: .start,
            alignItems: .stretch,
            children: [movieTitle, movieDescription]
        )
        titleAndDescriptionStack.style.flexBasis = ASDimensionMakeWithFraction(0.65)

        
        let mainStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 16,
            justifyContent: .start,
            alignItems: .stretch,
            children: [posterRatioSpec, titleAndDescriptionStack]
        )
        
        return mainStack
    }
}
