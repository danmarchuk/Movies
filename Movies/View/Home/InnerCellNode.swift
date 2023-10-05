//
//  HomeInnerCellNode.swift
//  Movies
//
//  Created by Данік on 29/09/2023.
//

import AsyncDisplayKit
import MBCircularProgressBar
import SnapKit
import SDWebImage

class InnerCellNode: ASCellNode {
    
    static let identifier = "SearchInnerCell"
    
    let moviePoster = ASNetworkImageNode().apply {
        $0.cornerRadius = 15
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.placeholderColor = .lightGray
        $0.placeholderEnabled = true
    }
    
    let circularProgressBarNode = CircularProgressBarNode()
    
    let percentageLabel: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "66%", attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.percentageGray
        ])
        return node
    }()
    
    let titleLabel: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Movie name", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.titleGray
        ])
        node.maximumNumberOfLines = 2
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

        percentageLabel.attributedText = NSAttributedString(string: "\(Int(movie.rating * 10))%", attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.percentageGray
        ])
        circularProgressBarNode.updateValue(to: movie.rating * 10)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        moviePoster.style.preferredSize = CGSize(width: 126, height: 140)  // example size
        circularProgressBarNode.style.preferredSize = CGSize(width: 15, height: 15)  // example size

        let progressBarWithPercentageStack = ASStackLayoutSpec.horizontal()
        progressBarWithPercentageStack.children = [circularProgressBarNode, percentageLabel]
        
        let mainVerticalStack = ASStackLayoutSpec.vertical()
        mainVerticalStack.children = [moviePoster, progressBarWithPercentageStack, titleLabel]
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: mainVerticalStack)
    }
}

