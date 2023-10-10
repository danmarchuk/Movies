//
//  ActorScreenNode.swift
//  Movies
//
//  Created by Данік on 06/10/2023.
//

import AsyncDisplayKit

final class ActorScreenNode: ASDisplayNode {
    
    let actorPhoto = ASNetworkImageNode()
    let actorNameLabel = ASTextNode()
    let jobLabel = ASTextNode()
    let biographyLabel = ASTextNode()
    let knownForLabel = ASTextNode()
    let knownForController = InnerHorizontalCollectionNode()
    let actingLabel = ASTextNode()
    let seeAllActing = ASTextNode()
    let actingVerticalControllerNode = ActingVerticalControllerNode()
    
    let scrollView: ASScrollNode = {
        let node = ASScrollNode()
        node.automaticallyManagesContentSize = true
        node.automaticallyManagesSubnodes = true
        return node
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
    }
    
    func configure(withActorInfo info: ActorFullInfo, withMovies movies: [ActingInfo]) {
        actorPhoto.url = URL(string: info.imageUrl)
        actorNameLabel.attributedText = NSAttributedString(string: info.nameAndSurname, attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])
        jobLabel.attributedText = NSAttributedString(string: info.job, attributes: [
            .font: UIFont(name: "OpenSans-Light", size: 14)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])
        biographyLabel.attributedText = NSAttributedString(string: info.biography, attributes: [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!,
            .foregroundColor: K.movieScreenGray2
        ])
        biographyLabel.maximumNumberOfLines = 8
        
        knownForLabel.attributedText = NSAttributedString(string: "Known For", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])
        
        actingLabel.attributedText = NSAttributedString(string: "Acting", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 18)!,
            .foregroundColor: K.movieScreenDarkBlueTextColor
        ])
        seeAllActing.attributedText = NSAttributedString(string: "See All", attributes: [
            .font: UIFont(name: "OpenSans-Semibold", size: 14)!,
            .foregroundColor: K.seeAllColor
        ])
        actingVerticalControllerNode.actingInfo = movies
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        actorPhoto.style.preferredSize = CGSize(width: constrainedSize.max.width / 3, height: constrainedSize.max.height / 4.5)
        knownForController.node.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 200)
        actingVerticalControllerNode.node.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 200)
//        knownForController.node.style.flexGrow = 1.0
        
        let verticalStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 4,
            justifyContent: .start,
            alignItems: .start,
            children: [ actorNameLabel, jobLabel, biographyLabel]
        )
        verticalStack.style.flexShrink = 1.0
        verticalStack.style.flexGrow = 1.0

        let horizontalStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 16,
            justifyContent: .start,
            alignItems: .start,
            children: [ actorPhoto, verticalStack]
        )
        
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        
        let horizontalStack2 = ASStackLayoutSpec.horizontal()
        horizontalStack2.spacing = 16
        horizontalStack2.children = [ actingLabel, spacer, seeAllActing]
        
        
        let mainVerticalStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 16,
            justifyContent: .start,
            alignItems: .start,
            children: [ horizontalStack, knownForLabel, knownForController.node, horizontalStack2, actingVerticalControllerNode.node ]
        )
        
        let layout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: mainVerticalStack)
        
        scrollView.automaticallyManagesContentSize = true
        scrollView.automaticallyManagesSubnodes = true
        scrollView.layoutSpecBlock = { node, constrainedSize in
            return layout
        }

        // Return the scroll view as the main layout spec:
        return ASWrapperLayoutSpec(layoutElement: scrollView)
    }

}
