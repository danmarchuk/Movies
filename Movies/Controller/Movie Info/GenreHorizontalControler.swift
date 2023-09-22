//
//  GenreTableViewController.swift
//  Movies
//
//  Created by Данік on 19/09/2023.
//

import Foundation
import UIKit

class GenreHorizontalControler: BaseListController {
    
    var listOfGenres: [String] = ["Trailer", "Drama", "Sci Fi", "Drama & Sci Fi"] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 10
            layout.scrollDirection = .horizontal
        }
    }
}

// MARK: - Delegate and Datasource methods
extension GenreHorizontalControler {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listOfGenres.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell else {
            return UICollectionViewCell()
        }
        cell.configure(withGenges: listOfGenres[indexPath.row])
        return cell
    }
}

// UICollectionViewDelegateFlowLayout
extension GenreHorizontalControler: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate the size of the text label
        let text = listOfGenres[indexPath.row]
        let textSize = (text as NSString).size(withAttributes: [
            NSAttributedString.Key.font: UIFont(name: "OpenSans-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
        ])
        
        // Add some padding to the text size
        let width = textSize.width + 20
        let height = textSize.height + 15
        
        return CGSize(width: width, height: height)
    }
}
