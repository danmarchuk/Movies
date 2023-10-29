//
//  HomeMainDisplayNode.swift
//  Movies
//
//  Created by Данік on 30/09/2023.
//

import Foundation
import AsyncDisplayKit

final class HomeMainDisplayNode: ASDisplayNode {
    
    let backgroundImageNode = ASImageNode().apply {
        $0.image = UIImage(named: "rickBackgroundImage")
        $0.contentMode = .scaleAspectFill
    }
    
    let gradientNode = ASDisplayNode().apply {
        $0.backgroundColor = .clear
    }
    
    let movieButton = ASButtonNode().apply {
        $0.setTitle("Movies", with: UIFont(name: "OpenSans-SemiBold", size: 14), with: K.searchBlack, for: .normal)
    }
    
    let tvShowsButton = ASButtonNode().apply {
        $0.setTitle("TV Shows", with: UIFont(name: "OpenSans-SemiBold", size: 14), with: K.searchBlack, for: .normal)
    }
    
    let peopleButton = ASButtonNode().apply {
        $0.setTitle("People", with: UIFont(name: "OpenSans-SemiBold", size: 14), with: K.searchBlack, for: .normal)
    }
    
    let moreButton = ASButtonNode().apply {
        $0.setTitle("More", with: UIFont(name: "OpenSans-SemiBold", size: 14), with: K.searchBlack, for: .normal)
    }
    
    let buttons = ["Movies", "TV Shows", "People", "More"]
    let verticalCollectionNode = OuterVerticalCollectionNode()
    private let scrollNode = ASScrollNode()

    override init() {
        super.init()
        backgroundColor = .white
        automaticallyManagesSubnodes = true
        addSubnode(backgroundImageNode)
    }
    
    override func layout() {
        super.layout()
        applyGradient(to: backgroundImageNode)
    }
    
    // Function to apply gradient to the given node
    private func applyGradient(to node: ASDisplayNode) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundImageNode.bounds
        gradientLayer.colors = [
            UIColor(red: 0.35, green: 0.78, blue: 0.98, alpha: 0.5).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

        backgroundImageNode.layer.addSublayer(gradientLayer)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // Calculate the height for the background image (3/5 of the screen height)
        backgroundImageNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.height * 3 / 5)
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        
        let backgroundSpec = ASStackLayoutSpec()
        backgroundSpec.children = [backgroundImageNode, spacer]
        
        let scrollNodeLayoutSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: -70, left: 0, bottom: 0, right: 0), child: backgroundSpec)
        let cellHeight = Int(verticalCollectionNode.node.bounds.height / K.homeMainCellHeightDivider)
        let totalSpacing: CGFloat = 100 * CGFloat(4) // spacing between cells
        let verticalCollectionNodeHeight = CGFloat(4 * cellHeight) + totalSpacing

        verticalCollectionNode.node.style.preferredSize = CGSize(width: constrainedSize.max.width, height: verticalCollectionNodeHeight)
        verticalCollectionNode.node.style.flexGrow = 1.0
        verticalCollectionNode.node.backgroundColor = .clear
        
        let horizontalButtonStack = ASStackLayoutSpec(direction: .horizontal,
                                                      spacing: 30,
                                                      justifyContent: .spaceAround,
                                                      alignItems: .stretch,
                                                      children: [movieButton, tvShowsButton, peopleButton, moreButton])

        let verticalStack = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 45,
                                              justifyContent: .start,
                                              alignItems: .stretch,
                                              children: [horizontalButtonStack, verticalCollectionNode.node])
        
        let overlaySpec = ASOverlayLayoutSpec(child: scrollNodeLayoutSpec, overlay: verticalStack)
        scrollNode.automaticallyManagesContentSize = true
        scrollNode.automaticallyManagesSubnodes = true
        scrollNode.layoutSpecBlock = { (_, _) -> ASLayoutSpec in
            return overlaySpec
        }
        scrollNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: verticalCollectionNodeHeight)
        return ASWrapperLayoutSpec(layoutElement: scrollNode)
    }

}
