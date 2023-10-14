//
//  SearchOuterController.swift
//  Movies
//
//  Created by Данік on 13/10/2023.
//

import Foundation
import AsyncDisplayKit

class SearchOuterController : ASDKViewController<ASCollectionNode>, ASCollectionDataSource, ASCollectionDelegate {
    
    var sections: [SearchSection] = [] {
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
        return sections.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let section = sections[indexPath.item]
        let cellNode = SearchOuterCellNode(withSection: section)
        return cellNode
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        // change the height
        let size = CGSize(width: collectionNode.bounds.width, height: collectionNode.bounds.height / 4)
        return ASSizeRange(min: size, max: size)
    }
    
    // MARK: - ASCollectionDelegate
    
//    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
//
//        let chosenMovie = moviesOrTvs[indexPath.row]
//        let movieOrTvVC = MovieOrTvViewControllerNode()
//        movieOrTvVC.movieOrTvId = String(chosenMovie.id)
//        movieOrTvVC.isMovie = chosenMovie.movie
//        let navigationController = ASDKNavigationController(rootViewController: movieOrTvVC)
//        navigationController.modalPresentationStyle = .fullScreen
//
//        present(navigationController, animated: true, completion: nil)
//
//    }
}
