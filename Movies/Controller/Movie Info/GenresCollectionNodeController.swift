//
//  GenresCollectionNodeController.swift
//  Movies
//
//  Created by Данік on 05/10/2023.
//

import AsyncDisplayKit

final class GenresCollectionNodeController: ASDKViewController<ASCollectionNode>, ASCollectionDataSource, ASCollectionDelegate {
    
    // Sample data for genres
    var genres: [String] = [] {
        didSet {
            node.reloadData()
        }
    }
    
    override init() {
        // Create a flow layout for the collection
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 40) // example item size
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        // Initialize the collectionNode with the flow layout
        let collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        
        super.init(node: collectionNode)
        
        // Set collectionNode's data source and delegate to self
        node.dataSource = self
        node.delegate = self
        node.alwaysBounceHorizontal = true
        node.backgroundColor = .white
    }
    
    
    // MARK: ASCollectionDataSource
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let genre = genres[indexPath.item]
        let cellNode = GenreCellNode()
        cellNode.configure(withGenges: genre)
        return cellNode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let genre = genres[indexPath.item]
        
        // Calculate the size of the text
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "OpenSans-Regular", size: 14)!
        ]
        let textSize = genre.size(withAttributes: attributes)
        
        // Add some padding
        let width = textSize.width + 20
        let height = textSize.height + 10
        
        return ASSizeRangeMake(CGSize(width: width, height: height), CGSize(width: width, height: height))
    }
}
