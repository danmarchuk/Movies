//
//  SearchScreenNode.swift
//  Movies
//
//  Created by Данік on 26/09/2023.
//

import Foundation
import Foundation
import AsyncDisplayKit

final class SearchScreenNode: ASDisplayNode {
    
    var isSearching: Bool = false {
        didSet {
            if isSearching {
                self.switchToSearchResults()
            } else {
                self.switchToTrending()
            }
        }
    }

    private let scrollView = ASScrollNode()
    let searchBarNode = SearchBarNode()
    var containerNode = ASDisplayNode() // Create a container node
    
    var showResults: Bool = false

    private let trendingLabel: ASTextNode = {
        let node = ASTextNode()
        node.attributedText =
        NSAttributedString(string: "Trending", attributes: [NSAttributedString.Key.font: UIFont(name: "OpenSans-Semibold", size: 18), NSAttributedString.Key
            .foregroundColor: K.movieScreenDarkBlueTextColor])
        return node
    }()
    
    let verticalCollectionNode = SearchVerticalTrendingControllerNode()
    let searchOuterController = SearchOuterController()

    override init() {
        super.init()
        containerNode.automaticallyManagesSubnodes = true
        containerNode.automaticallyRelayoutOnSafeAreaChanges = true
        automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        backgroundColor = .white
        // Stack all nodes vertically
        let fullwidthSearchBar = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: -10, bottom: 0, right: -10), child: searchBarNode)
        
        let cellHeight: CGFloat = 80
        let totalSpacing: CGFloat = 10 * CGFloat(20 - 1) // spacing between cells
        let totalHeight: CGFloat = cellHeight * CGFloat(20) + totalSpacing
        verticalCollectionNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: totalHeight)
        let verticalCollectionNodeSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: verticalCollectionNode)
        
                
        let searchOuterControllerSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: searchOuterController.node)
        
        if isSearching {
            containerNode.layoutSpecBlock = { _, _ in
                return ASStackLayoutSpec(
                    direction: .vertical,
                    spacing: 0,
                    justifyContent: .start,
                    alignItems: .start,
                    children: [searchOuterControllerSpec]
                )
            }
        } else {
            containerNode.layoutSpecBlock = { [self] _, _ in
                return ASStackLayoutSpec(
                    direction: .vertical,
                    spacing: 16,
                    justifyContent: .start,
                    alignItems: .start,
                    children: [trendingLabel, verticalCollectionNodeSpec]
                )
            }
        }
                
        var verticalStackContent: [ASLayoutElement] = [fullwidthSearchBar, containerNode]
                
        
        let verticalStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10,
            justifyContent: .start,
            alignItems: .stretch,
            children: verticalStackContent
        )
        
        
        
        searchBarNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 40)

        // Insert vertical stack in a scrollable content
        scrollView.automaticallyManagesContentSize = true
        scrollView.automaticallyManagesSubnodes = true
        scrollView.layoutSpecBlock = { _, _ in
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: self.safeAreaInsets.top + 10, left: 16, bottom: 0, right: 16), child: verticalStack)
        }
        
        return ASWrapperLayoutSpec(layoutElement: scrollView)
    }
    
    private func switchToTrending() {
        searchOuterController.node.removeFromSupernode()
        containerNode.addSubnode(trendingLabel)
        containerNode.addSubnode(verticalCollectionNode)
    }

    private func switchToSearchResults() {
        trendingLabel.removeFromSupernode()
        verticalCollectionNode.removeFromSupernode()
        containerNode.addSubnode(searchOuterController.node)
        // Perform your search logic and update the results in searchOuterController
    }
}
