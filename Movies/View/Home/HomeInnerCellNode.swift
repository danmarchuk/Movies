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

class HomeInnerCellNode: ASCellNode {
    
    static let identifier = "SearchInnerCell"
    
    let moviePoster: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.image = UIImage(named: "welcomeScreenBackgroundImage")
        node.cornerRadius = 15
        node.clipsToBounds = true
        node.contentMode = .scaleAspectFill
        return node
    }()
    
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
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
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
        circularProgressBarNode.updateValue(to: movie.rating)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // Replace the SnapKit constraints with Texture's layout specs
        // You'll need to adjust this based on your exact needs
        
        let progressBarWithPercentageStack = ASStackLayoutSpec.horizontal()
        progressBarWithPercentageStack.children = [circularProgressBarNode, percentageLabel]
        
        let mainVerticalStack = ASStackLayoutSpec.vertical()
        mainVerticalStack.children = [moviePoster, progressBarWithPercentageStack, titleLabel]
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: mainVerticalStack)
    }
}

