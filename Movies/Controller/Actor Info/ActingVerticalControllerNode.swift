//
//  ActingVerticalControllerNode.swift
//  Movies
//
//  Created by Данік on 06/10/2023.
//
import Foundation
import AsyncDisplayKit

final class ActingVerticalControllerNode: ASDKViewController<ASCollectionNode>, ASCollectionDataSource, ASCollectionDelegate {
        
    var actingInfo: [ActingInfo] = [] {
        didSet {
            node.reloadData()
        }
    }
    
    override init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: collectionNode)
        node.delegate = self
        node.dataSource = self
        node.alwaysBounceHorizontal = true
        node.backgroundColor = .white
        node.view.isScrollEnabled = false

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ASCollectionDataSource
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return actingInfo.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let movie = actingInfo[indexPath.item]
        let cellNode = ActingCellNode(info: movie)
        cellNode.delegate = self
        return cellNode
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: collectionNode.bounds.width, height: collectionNode.bounds.height / K.actingCellHeightDivider)
        return ASSizeRange(min: size, max: size)
    }
}

// MARK: - ActingCellDelegate
extension ActingVerticalControllerNode: ActingCellDelegate {
    func didTouchTheTitle(actingInfo: ActingInfo) {
        let movieOrTvVC = MovieOrTvViewControllerNode()
        movieOrTvVC.movieOrTvId = String(actingInfo.id)
        movieOrTvVC.isMovie = actingInfo.isMovie
        let navigationController = ASDKNavigationController(rootViewController: movieOrTvVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}
