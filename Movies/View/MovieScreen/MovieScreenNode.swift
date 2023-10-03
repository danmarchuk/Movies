//
//  MovieScreenNode.swift
//  Movies
//
//  Created by Данік on 02/10/2023.
//

import Foundation

import AsyncDisplayKit

final class MovieScreenNode: ASDisplayNode {
    
    let titleLabel = ASTextNode()
    let yearLabel = ASTextNode()
    let ageRestrictionLabel = ASTextNode()
    let circularProgressBar = CircularProgressBarNode()
    let percentageLabel = ASTextNode()
    let movieLengthLabel = ASTextNode()
    
    let moviePoster = ASNetworkImageNode().apply {
        $0.contentMode = .scaleAspectFill
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
    }
    
    let genres = GenreHorizontalControler()
    
    

    let storylineLabel = ASTextNode().apply {
        $0.attributedText = NSAttributedString(
            string: "The show follows the character...",
            attributes: [
                .font: UIFont(name: "OpenSans-Regular", size: 16)!,
                .foregroundColor: UIColor.black
            ]
        )
    }

    let castTitleLabel = ASTextNode().apply {
        $0.attributedText = NSAttributedString(
            string: "Cast",
            attributes: [
                .font: UIFont(name: "OpenSans-Bold", size: 18)!,
                .foregroundColor: K.movieScreenDarkBlueTextColor
            ]
        )
    }

    let castNode = ASImageNode().apply {
        $0.image = UIImage(named: "cast_image")
        $0.contentMode = .scaleAspectFill
    }

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // Vertical stack for the main components
        let mainStack = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 10,
                                              justifyContent: .start,
                                              alignItems: .start,
                                              children: [titleLabel, moviePoster, yearLabel, titleLabel, storylineLabel, castTitleLabel, castNode])
        
        return mainStack
    }
    
    func configure(withMovieFullInfo info: MovieOrTVFullInfo) {
        titleLabel.attributedText = NSAttributedString(
            string: info.title,
            attributes: [
                .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
                .foregroundColor: K.movieScreenDarkBlueTextColor
            ]
        )
        storylineLabel.attributedText = NSAttributedString(
            string: info.description,
            attributes: [
                .font: UIFont(name: "OpenSans-Regular", size: 16)!,
                .foregroundColor: UIColor.black
            ]
        )
        // Similarly update other nodes...
    }
}

