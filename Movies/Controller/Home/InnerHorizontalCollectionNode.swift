//
//  InnerHorizontalViewControllerNode.swift
//  Movies
//
//  Created by Данік on 29/09/2023.
//

import Foundation
import AsyncDisplayKit

class InnerHorizontalCollectionNode: ASDKViewController<ASCollectionNode>, ASCollectionDataSource, ASCollectionDelegate {
    
    var moviesOrTvs: [MovieOrTvInfo] = [] {
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
        node.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ASCollectionDataSource
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return moviesOrTvs.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let movie = moviesOrTvs[indexPath.item]
        let cellNode = InnerCellNode(movie: movie)
        return cellNode
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: collectionNode.bounds.width / 3, height: collectionNode.bounds.height)
        return ASSizeRange(min: size, max: size)
    }
    
    // MARK: - ASCollectionDelegate
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {

        let chosenMovie = moviesOrTvs[indexPath.row]
        let movieOrTvVC = MovieOrTvViewControllerNode()
        movieOrTvVC.movieOrTvId = String(chosenMovie.id)
        movieOrTvVC.isMovie = chosenMovie.movie
        let navigationController = ASDKNavigationController(rootViewController: movieOrTvVC)
        navigationController.modalPresentationStyle = .fullScreen

        present(navigationController, animated: true, completion: nil)

    }
}

