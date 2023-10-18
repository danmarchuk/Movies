//
//  SearchMovieOrTvController.swift
//  Movies
//
//  Created by Данік on 13/10/2023.
//

import Foundation
import AsyncDisplayKit

class SearchInnerController: ASDKViewController<ASCollectionNode>, ASCollectionDataSource, ASCollectionDelegate {
    
    var movieOrTvInfo: [MovieOrTvInfo]? = [] {
        didSet {
            node.reloadData()
        }
    }
    
    var peopleInfo: [PersonInfo]? = [] {
        didSet {
            node.reloadData()
        }
    }
    
    var companiesInfo: [Company]? = [] {
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
        return 3
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        if let movies = movieOrTvInfo, indexPath.item < movies.count {
            let movie = movies[indexPath.item]
            let cellNode = MovieOrTvCellNode(info: movie)
            return cellNode
        } else if let people = peopleInfo, indexPath.item < people.count {
            let person = people[indexPath.item]
            let cellNode = SearchPersonCellNode(info: person)
            return cellNode
        } else if let companies = companiesInfo, indexPath.item < companies.count{
            let company = companies[indexPath.item]
            let cellNode = SearchCompanyCellNode(info: company)
            return cellNode
        } else {
            return ASCellNode()
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: collectionNode.bounds.width, height: collectionNode.bounds.height / K.searchResultsCellHeightDivider)
        return ASSizeRange(min: size, max: size)
    }
    
    // MARK: - ASCollectionDelegate
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        if let movies = movieOrTvInfo, indexPath.item < movies.count {
            let chosenMovie = movies[indexPath.row]
            let movieOrTvVC = MovieOrTvViewControllerNode()
            movieOrTvVC.movieOrTvId = String(chosenMovie.id)
            movieOrTvVC.isMovie = chosenMovie.movie
            let navigationController = ASDKNavigationController(rootViewController: movieOrTvVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        } else if let people = peopleInfo, indexPath.item < people.count {
            let chosenPerson = people[indexPath.item]
            let actorVC = ActorInfoViewControllerNode()
            actorVC.actorId = String(chosenPerson.id)
            let navigationController = ASDKNavigationController(rootViewController: actorVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        }
    }
}
