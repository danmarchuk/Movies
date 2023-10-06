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
    
    
    override init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: collectionNode)
        
        node.delegate = self
        node.dataSource = self
        node.alwaysBounceHorizontal = true
        node.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ASCollectionDataSource
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return actorShortInfo.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let actor = actorShortInfo[indexPath.item]
        let cellNode = ActorCellNode(actor: actor)
        return cellNode
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: collectionNode.bounds.width / 3, height: collectionNode.bounds.height)
        return ASSizeRange(min: size, max: size)
    }
    
    // MARK: - ASCollectionDelegate
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {

        let chosenActor = actorShortInfo[indexPath.row]
        let actorVC = ActorInfoViewControllerNode()
        actorVC.actorId = String(chosenActor.id)
        let navigationController = ASDKNavigationController(rootViewController: actorVC)
        navigationController.modalPresentationStyle = .fullScreen

        present(navigationController, animated: true, completion: nil)

    }
}

