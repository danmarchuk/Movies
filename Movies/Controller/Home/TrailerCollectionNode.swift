//
//  TrailerCollectionNode.swift
//  Movies
//
//  Created by Данік on 21/10/2023.
//

import Foundation
import AsyncDisplayKit

final class TrailerCollectionNode: ASDKViewController<ASCollectionNode>, ASCollectionDataSource, ASCollectionDelegate {
    
    var moviesOrTvs: [MovieOrTvInfo] = [] {
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
        node.view.showsVerticalScrollIndicator = false
        node.view.showsHorizontalScrollIndicator = false
        node.delegate = self
        node.dataSource = self
        node.alwaysBounceHorizontal = true
        node.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ASCollectionDataSource
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return moviesOrTvs.count + 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        if indexPath.item == 0 {
            return ghostCell
        } else if indexPath.item <= moviesOrTvs.count {
            let movie = moviesOrTvs[indexPath.item - 1]
            let cellNode = InnerTrailerCellNode(movie: movie)
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
            let size = CGSize(width: collectionNode.bounds.width / 1.4, height: collectionNode.bounds.height / 1.2)
            return ASSizeRange(min: size, max: size)
        }
    }
    
    // MARK: - ASCollectionDelegate
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item > 0 && indexPath.item <= moviesOrTvs.count {
            let chosenMovie = moviesOrTvs[indexPath.row - 1]
            let movieOrTvVC = MovieOrTvViewControllerNode()
            movieOrTvVC.movieOrTvId = String(chosenMovie.id)
            movieOrTvVC.isMovie = chosenMovie.movie
            let navigationController = ASDKNavigationController(rootViewController: movieOrTvVC)
            navigationController.modalPresentationStyle = .fullScreen
            
            present(navigationController, animated: true, completion: nil)
        }
    }
}

