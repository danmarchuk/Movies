//
//  ActorInfoViewControllerNode.swift
//  Movies
//
//  Created by Данік on 05/10/2023.
//

import Foundation
import AsyncDisplayKit

class CastViewControllerNode: ASDKViewController<ASCollectionNode>, ASCollectionDataSource, ASCollectionDelegate {
    
    var actorShortInfo: [ActorShortInfo] = [] {
        didSet {
            node.reloadData()
        }
    }
    
    let ghostCell = ASCellNode()
    
    override init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: collectionNode)
        
        node.delegate = self
        node.dataSource = self
        node.alwaysBounceHorizontal = true
        node.view.showsVerticalScrollIndicator = false
        node.view.showsHorizontalScrollIndicator = false
        node.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ASCollectionDataSource
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return actorShortInfo.count + 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        if indexPath.item == 0 {
            // Handle the ghost cell, e.g., display a placeholder at the beginning
            return ghostCell
        } else if indexPath.item <= actorShortInfo.count {
            let actor = actorShortInfo[indexPath.item - 1]
            let cellNode = ActorCellNode(actor: actor)
            return cellNode
        } else {
            return ASCellNode()
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        if indexPath.item == 0 {
            let size = CGSize(width: 7, height: collectionNode.bounds.height)
            return ASSizeRange(min: size, max: size)
        } else {
            let size = CGSize(width: collectionNode.bounds.width / 4.5, height: collectionNode.bounds.height)
            return ASSizeRange(min: size, max: size)
        }
    }
    
    // MARK: - ASCollectionDelegate
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item > 0 && indexPath.item <= actorShortInfo.count {
            let chosenActor = actorShortInfo[indexPath.item - 1]
            let actorVC = ActorInfoViewControllerNode()
            actorVC.actorId = String(chosenActor.id)
            let navigationController = ASDKNavigationController(rootViewController: actorVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        }
        
    }
}

