//
//  GenreTableViewCell.swift
//  Movies
//
//  Created by Данік on 19/09/2023.
//

import Foundation
import UIKit
import SnapKit

class GenreCell: UICollectionViewCell {
    
    static let identifier = "GenreTableViewCell"
    
    let customLabel = UILabel().apply {
        $0.textAlignment = .center
        $0.text = "drama"
        $0.font = UIFont(name: "OpenSans-Regular", size: 14)
        $0.textColor = K.movieScreenGray2
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        // Add the label to the cell's content view
        contentView.addSubview(customLabel)

        // Configure the cell's appearance
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderColor = K.movieScreenBorderColor

        // Define constraints using SnapKit
        customLabel.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }
    }
    
    func configure(withGenges genres: String) {
        customLabel.text = genres
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
