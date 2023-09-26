//
//  SearchVerticalTrendingControllerNode.swift
//  Movies
//
//  Created by Данік on 26/09/2023.
//

import Foundation

import AsyncDisplayKit

class SearchVerticalTrendingControllerNode: ASDKViewController<ASCollectionNode>, ASCollectionDataSource, ASCollectionDelegateFlowLayout {
    
    var contents: [MovieOrTvInfo] = [] {
        didSet {
            node.reloadData()
        }
    }
    
    override init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .vertical
        super.init(node: ASCollectionNode(collectionViewLayout: flowLayout))
        self.node.dataSource = self
        self.node.delegate = self
        self.node.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        node.sc = false
    }
    
    // MARK: - ASCollectionDataSource methods
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let movieOrTv = contents[indexPath.row]
        return {
            let cell = TrendingCellNode(movieOrTv: movieOrTv)
            return cell
        }
    }
    
    // MARK: - ASCollectionDelegateFlowLayout methods
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let itemSize = CGSize(width: view.frame.width, height: 80)
        return ASSizeRange(min: itemSize, max: itemSize)
    }
}
